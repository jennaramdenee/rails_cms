class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title,   required: true
      t.string :summary, required: true
      t.text   :body,    required: true, limit: 50_000  # Text is a bigger field type

      t.timestamps
    end
  end
end
