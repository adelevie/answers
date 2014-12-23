module Answers
  module Testing
    module FeatureMacros
      module Authentication
        def answers_login_with(factory)
          let!(:logged_in_user) { FactoryGirl.create(factory) }

          before do
            login_as logged_in_user, :scope => :answers_user
          end
        end
      end
    end
  end
end
