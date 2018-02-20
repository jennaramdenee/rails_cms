FactoryBot.define do
  factory :original_article, class: Article do
    title 'Pass the parse-ly please'
    summary "Peter preferred peppers, but feeling partly perky, Peter asked Paul to please 'pass the parse-ly'"
    body File.read("#{Rails.root}/spec/fixtures/original_markdown_body.txt")
  end

  factory :converted_article, class: Article do
    title 'Pass the parse-ly please'
    summary "Peter preferred peppers, but feeling partly perky, Peter asked Paul to please 'pass the parse-ly'"
    body File.read("#{Rails.root}/spec/fixtures/converted_markdown_body.txt")
  end
end
