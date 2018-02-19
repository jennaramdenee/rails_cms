class ChangeArticles < ActiveRecord::Migration[5.1]
  def change
    change_column_null :articles, :summary, true
    change_column_null :articles, :body, true
    change_column_null :articles, :title, false
  end
end
