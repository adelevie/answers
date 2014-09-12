class AddSlugToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :slug, :text, :uniqueness => true

    add_index :questions, :slug
  end
end
