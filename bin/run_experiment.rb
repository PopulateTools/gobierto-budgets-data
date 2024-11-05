# frozen_string_literal: true

require "csv"

# This file loads the base CSV generated in prepare_experiment.rb, and runs the experiment
# updating the CSV with the new answers and prompts

if ARGV.size != 1
  raise "Error: the name of the experiment results file is required. It should include the .csv extension"
end

# Base is generated in prepare_experiment.rb with the current answers and prompts
base_csv = CSV.read("base.csv", headers: true)

CSV.open(ARGV[0], "wb") do |csv|
  csv << ["id","question", "answer", "prompt", "weights", "experiment_answer", "experiment_prompt"]
  base_csv.each do |row|

    qa = QuestionAnswer.find(row["id"])

    responder = Assistant::AnswerQuestionWithOpenAI.new(qa.question)
    experiment_prompt, _, experiment_answer = responder.call

    csv << [row["id"], row["question"], row["answer"], row["prompt"], row["weights"], experiment_answer, experiment_prompt]
  end
end
