require 'spec_helper'
require "cancan/matchers"

describe Ability, :type => :model do
  subject { Ability.new(user) }
  let (:user) { nil }

  context 'when user is just a user' do
    let (:user) { create(:user_no_abilities) }
    pending 'why'
    it { is_expected.to be_able_to(:read, Question.new) }
    it { is_expected.to be_able_to(:read, Answer.new) }

    it { is_expected.not_to be_able_to(:manage, Question.new) }
    it { is_expected.not_to be_able_to(:manage, Answer.new) }
  end

  context 'when user is an editor' do
    let (:user) { create(:editor) }

    it { is_expected.to be_able_to(:manage, Question.new) }
    it { is_expected.to be_able_to(:manage, Answer.new) }

    it { is_expected.not_to be_able_to(:manage, User.new) }
  end

  context 'when user is a writer' do
    let (:user) { create(:writer) }

    it { is_expected.to be_able_to(:create, Question.new) }
    it { is_expected.to be_able_to(:create, Answer.new) }

    it { is_expected.not_to be_able_to(:manage, User.new) }
  end

end