class CreateJoinTableArticleCollection < ActiveRecord::Migration[5.1]
  def change
    create_join_table :articles, :collections do |t|
      t.index [:article_id, :collection_id]
      t.index [:collection_id, :article_id]
    end
  end
end
