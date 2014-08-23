class RemoveUrlFromQuestion < ActiveRecord::Migration
  def change
    remove_column :questions, :url, :string
  end
end
