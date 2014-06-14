require 'spec_helper'
require "cancan/matchers"

describe Ability, :type => :model do
  subject { Ability.new(user) }
  let (:user) { nil }

  context 'when user is just a user' do
    let (:user) { create(:user_no_abilities) }
    pending 'why'
    it { is_expected.to be_able_to(:read, Article.new) }
    it { is_expected.to be_able_to(:read, Contact.new) }
    it { is_expected.to be_able_to(:read, QuickAnswer.new) }

    it { is_expected.not_to be_able_to(:manage, Article.new) }
    it { is_expected.not_to be_able_to(:manage, Contact.new) }
    it { is_expected.not_to be_able_to(:manage, User.new) }
  end

  context 'when user is an editor' do
    let (:user) { create(:editor) }

    it { is_expected.to be_able_to(:manage, QuickAnswer.new) }
    it { is_expected.to be_able_to(:manage, Contact.new) }
    it { is_expected.to be_able_to(:manage, Category.new) }

    it { is_expected.not_to be_able_to(:manage, User.new) }
  end

  context 'when user is a writer' do
    let (:user) { create(:writer) }

    it { is_expected.to be_able_to(:create, QuickAnswer.new) }
    it { is_expected.to be_able_to(:create, Contact.new) }
    it { is_expected.to be_able_to(:create, Category.new) }
    it { is_expected.to be_able_to(:update, QuickAnswer.create(:title => 'can u update?', :user_id => user.id)) }
    it { is_expected.to be_able_to(:destroy, QuickAnswer.create(:title => 'can u delete?', :user_id => user.id)) }
    it { is_expected.to be_able_to(:destroy, Guide.new(:user_id => user.id)) }

    it { is_expected.not_to be_able_to(:manage, User.new) }
    it { is_expected.not_to be_able_to(:manage, Contact.new) }
    it { is_expected.not_to be_able_to(:manage, QuickAnswer.new) }
  end

end