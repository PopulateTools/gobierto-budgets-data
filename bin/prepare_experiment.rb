# frozen_string_literal: true

require "csv"

# This file dumps in a CSV the questions and answers from the database
# This CSV will be used later to run the experiment (run_experiment.rb)
# Where an experiment is a variation of the parameters used to generate the answer, the prompt and the weights
# that needs to be measured

CSV.open("base.csv", "wb") do |csv|
  csv << ["id", "question", "answer", "prompt", "weights"]
  QuestionAnswer.order(id: :asc).each do |qa|
    csv << [qa.id, qa.question, qa.answer, qa.prompt, qa.weights]
  end
end
