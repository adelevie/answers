class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.text :need_to_know
      t.text :text
      t.string :url
      t.string :in_language
      t.references :question, index: true

      t.timestamps
    end
  end
end
