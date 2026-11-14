# Gobierto budgets data

Spanish municipal budgets (CONPREL, Ministerio de Hacienda) stored as gzipped SQL files in
`data/presupuestos_municipales/<year>/<planned|executed>/`, plus shell scripts to convert and load them.
See README.md for the data model.

- `bin/convert <zip|accdb> <year> <planned|executed>`: Access database to `.sql.gz` files (mdbtools).
- `bin/import <database> <planned|executed> [year]`: loads the files into Postgres with `psql`.
- `bin/report <database>`: missing municipalities per year in `docs/<year>.md`.

Dependencies: `brew bundle` (mdbtools, postgresql).

## Importing a ZIP downloaded from Hacienda

When asked to import a ZIP (usually in `~/Desktop` or `~/Downloads`):

1. Work in a branch, never on master.
2. Find the year and kind from the ZIP name: `Presupuestos<year>` is `planned`; `Liquidaciones<year>`
   is `executed`. If the name doesn't make it clear, ask. `unzip -l` lists its contents.
3. `brew bundle check || brew bundle`.
4. `bin/convert <zip> <year> <kind>`. It replaces existing files of that year and kind: republished
   years with more entities are expected.
5. Sanity check against the previous version (`git diff --stat`) and the previous year: same set of
   tables and comparable row counts (`gzip -dc <file> | wc -l`). A file with almost no rows means
   the conversion failed.
6. Load it locally: `bin/import budgets-<kind> <kind> <year>`, and check the tables
   `tb_*_<year>` have rows.
7. Update the years in the first paragraph of README.md.
8. Commit the data and open a PR. Only local databases are loaded; never production.
