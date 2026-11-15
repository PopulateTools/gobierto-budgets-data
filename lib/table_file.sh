# Writes a Postgres table as a gzipped, self-contained SQL file:
# DROP + CREATE TABLE followed by a COPY block with the rows.
# Text columns are stripped of leading and trailing spaces, because the
# Access sources pad codes and names to the column width.
#
# Usage: write_table_file <database> <table> <output.sql.gz>
write_table_file() {
  local database=$1 table=$2 output=$3

  local column_definitions column_names select_list
  column_definitions=$(table_query "$database" "$table" \
    "string_agg(format(E'\t%I %s', attname, replace(upper(format_type(atttypid, atttypmod)), 'CHARACTER VARYING', 'VARCHAR')),E',\n' ORDER BY attnum)")
  column_names=$(table_query "$database" "$table" \
    "string_agg(format('%I', attname), ', ' ORDER BY attnum)")
  select_list=$(table_query "$database" "$table" \
    "string_agg(CASE WHEN atttypid IN ('varchar'::regtype, 'text'::regtype, 'bpchar'::regtype)
                     THEN format('btrim(%I)', attname)
                     ELSE format('%I', attname) END, ', ' ORDER BY attnum)")

  {
    printf 'DROP TABLE IF EXISTS "%s" CASCADE;\n' "$table"
    printf 'CREATE TABLE "%s" (\n%s\n);\n\n' "$table" "$column_definitions"
    printf 'COPY "%s" (%s) FROM stdin;\n' "$table" "$column_names"
    psql -X -q -v ON_ERROR_STOP=1 -d "$database" \
      -c "\\copy (SELECT $select_list FROM \"$table\") TO STDOUT"
    printf '\\.\n'
  } | gzip -9 -n > "$output"
}

table_query() {
  local database=$1 table=$2 aggregate=$3
  psql -X -At -v ON_ERROR_STOP=1 -d "$database" -c "
    SELECT $aggregate
    FROM pg_attribute
    WHERE attrelid = '\"$table\"'::regclass AND attnum > 0 AND NOT attisdropped"
}
