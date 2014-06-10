require 'spec_helper'
require "cancan/matchers"

describe Ability do
  subject { Ability.new(user) }
  let (:user) { nil }

  context 'when user is just a user' do
    let (:user) { create(:user_no_abilities) }

    it { should be_able_to(:read, Article.new) }
    it { should be_able_to(:read, Contact.new) }
    it { should be_able_to(:read, QuickAnswer.new) }

    it { should_not be_able_to(:manage, Article.new) }
    it { should_not be_able_to(:manage, Contact.new) }
    it { should_not be_able_to(:manage, User.new) }
  end

  context 'when user is an editor' do
    let (:user) { create(:editor) }

    it { should be_able_to(:manage, QuickAnswer.new) }
    it { should be_able_to(:manage, Contact.new) }
    it { should be_able_to(:manage, Category.new) }

    it { should_not be_able_to(:manage, User.new) }
  end

  context 'when user is a writer' do
    let (:user) { create(:writer) }

    it { should be_able_to(:create, QuickAnswer.new) }
    it { should be_able_to(:create, Contact.new) }
    it { should be_able_to(:create, Category.new) }
    it { should be_able_to(:update, QuickAnswer.create(:title => 'can u update?', :user_id => user.id)) }
    it { should be_able_to(:destroy, QuickAnswer.create(:title => 'can u delete?', :user_id => user.id)) }
    it { should be_able_to(:destroy, Guide.new(:user_id => user.id)) }

    it { should_not be_able_to(:manage, User.new) }
    it { should_not be_able_to(:manage, Contact.new) }
    it { should_not be_able_to(:manage, QuickAnswer.new) }
  end

end