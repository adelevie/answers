class AnswersUp < ActiveRecord::Migration

  def change

    create_table :answers_answers do |t|
      t.text :need_to_know
      t.text :text
      t.string :url
      t.string :in_language
      t.references :question, index: true

      t.timestamps
    end

    add_index :answers_answers, :id


    create_table :answers_questions do |t|
      t.string :text
      t.string :url
      t.string :in_language

      t.timestamps
    end

    add_index :answers_questions, :id


    # USERS

    create_table(:answers_users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      # t.string :password_salt

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      # Token authenticatable
      t.string :authentication_token

      ## Invitable
      # t.string :invitation_token

      t.timestamps

      # 
      t.boolean  "is_editor"
      t.boolean  "is_admin",               default: false
      t.boolean  "is_writer",              default: false
    end
  end

end
