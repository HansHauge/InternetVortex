class AddSummaryToMemebaseArticles < ActiveRecord::Migration
  def change
    add_column :memebase_articles, :summary, :text
  end
end
