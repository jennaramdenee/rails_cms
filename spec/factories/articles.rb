FactoryBot.define do
  factory :article do
    title 'Test Article'
    summary 'Test Article Summary'
    body File.read("#{Rails.root}/spec/fixtures/markdown_body.txt")
  end
end
