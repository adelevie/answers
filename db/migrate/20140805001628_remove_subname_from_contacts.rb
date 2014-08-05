class RemoveSubnameFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :subname
  end
end
