class AddGuidToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :guid, :string
  end
end
