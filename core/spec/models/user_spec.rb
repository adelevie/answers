require 'spec_helper'

describe Answers::User, :type => :model do
  it "is valid with an email, password and password confirmation" do
    user = Answers::User.new(
        :email => 'user@example.com',
        :password => 'passwordsrsly',
        :password_confirmation => 'passwordsrsly'
      )

    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = Answers::User.new(
        :password => 'passwordsrsly',
        :password_confirmation => 'passwordsrsly'
      )

    expect(user.valid?).to be false
    expect(user.errors[:email].size).to eq(1)
  end

  it "is invalid without a valid email" do
    user = Answers::User.new(
        :email => '+++ FREE PHARMACY ?ONLINE!! +++',
        :password => 'passwordsrsly',
        :password_confirmation => 'passwordsrsly'
      )

    expect(user.valid?).to be false
    expect(user.errors[:email].size).to eq(1)
  end

  it "is invalid without a password and confirmation" do
    user = Answers::User.new(
        :email => 'user@example.com'
      )
    expect(user.valid?).to be false
    expect {user.save!}.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Password can't be blank")
  end

  it "has only one role" do
    user = Answers::User.new(
        :email => 'user@example.com',
        :password => 'passwordsrsly',
        :password_confirmation => 'passwordsrsly',
        :is_admin => true,
        :is_editor => true
      )
    user.save
    expect(user.is_admin?).to eq true
    expect(user.is_writer).to eq false
  end
end