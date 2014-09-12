class AnswersUp < ActiveRecord::Migration

  def change

    create_table :answers do |t|
      t.text :need_to_know
      t.text :text
      t.string :url
      t.string :in_language
      t.references :question, index: true

      t.timestamps
    end

    add_index :answers, :id


    create_table :questions do |t|
      t.string :text
      t.string :url
      t.string :in_language

      t.timestamps
    end

    add_index :questions, :id

  end

end
