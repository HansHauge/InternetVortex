class AddMoreSlug < ActiveRecord::Migration
  def change
    add_column :jokes, :slug, :string
    add_index :jokes, :slug
  end
end
