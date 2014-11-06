class QuestionLength < ActiveRecord::Migration
  def change
    change_column :answers_questions, :text, :text, :limit => nil
  end
end
