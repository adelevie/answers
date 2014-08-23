class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :text
      t.string :url
      t.string :in_language

      t.timestamps
    end
  end
end
