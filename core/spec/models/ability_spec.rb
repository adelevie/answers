require 'spec_helper'
require "cancan/matchers"

describe Answers::Ability, :type => :model do
  subject { Answers::Ability.new(user) }
  let (:user) { nil }

  context 'when user is just a user' do
    let (:user) { create(:user_no_abilities) }

    it { is_expected.to be_able_to(:read, Answers::Question.new) }
    it { is_expected.to be_able_to(:read, Answers::Answer.new) }

    it { is_expected.not_to be_able_to(:manage, Answers::Question.new) }
    it { is_expected.not_to be_able_to(:manage, Answers::Answer.new) }
  end

  context 'when user is an editor' do
    let (:user) { create(:editor) }

    it { is_expected.to be_able_to(:manage, Answers::Question.new) }
    it { is_expected.to be_able_to(:manage, Answers::Answer.new) }

    it { is_expected.not_to be_able_to(:manage, Answers::User.new) }
  end

  context 'when user is a writer' do
    let (:user) { create(:writer) }

    it { is_expected.to be_able_to(:create, Answers::Question.new) }
    it { is_expected.to be_able_to(:create, Answers::Answer.new) }

    it { is_expected.not_to be_able_to(:manage, Answers::User.new) }
  end

end