FactoryBot.define do
  factory :article do
    title 'Pass the parse-ly please'
    summary "Peter preferred peppers, but feeling partly perky, Peter asked Paul to please 'pass the parse-ly'"
    body File.read("#{Rails.root}/spec/fixtures/markdown_body.txt")
  end

  factory :transformed_article do
    title 'Pass the parse-ly please'
    summary "Peter preferred peppers, but feeling partly perky, Peter asked Paul to please 'pass the parse-ly'"
    body File.read("#{Rails.root}/spec/fixtures/correct_markdown_body.txt")
  end
end
