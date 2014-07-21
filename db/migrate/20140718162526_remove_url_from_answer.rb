class RemoveUrlFromAnswer < ActiveRecord::Migration
  def change
    remove_column :answers, :url, :string
  end
end
