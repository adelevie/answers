module Answers
  module Testing
    module ControllerMacros
      module Authentication
        def self.extended(base)
          base.send :include, Devise::TestHelpers
        end

        def answers_login_with(*roles)
          mock_user roles
        end

        def answers_login_with_factory(factory)
          factory_user factory
        end

        def mock_user(roles)
          let(:controller_permission) { true }
          roles = handle_deprecated_roles! roles
          let(:logged_in_user) do
            user = double 'Answers::User', :username => 'Joe Fake'

            roles.each do |role|
              user.stub(:has_role?).with(role).and_return true
            end
            user.stub(:has_role?).with(:superuser).and_return false if roles.exclude? :superuser

            user
          end

          before do
            controller.should_receive(:require_answers_users!).and_return false
            controller.should_receive(:authenticate_answers_user!).and_return true
            controller.should_receive(:restrict_plugins).and_return true
            controller.should_receive(:allow_controller?).and_return controller_permission
            controller.stub(:answers_user?).and_return true
            controller.stub(:current_answers_user).and_return logged_in_user
          end
        end

        def factory_user(factory)
          let(:logged_in_user) { FactoryGirl.create factory }
          before do
            @request.env["devise.mapping"] = Devise.mappings[:admin]
            sign_in logged_in_user
          end
        end

        private
        def handle_deprecated_roles!(*roles)
          mappings = {
            :user => [],
            :answers_user => [:answers],
            :answers_superuser => [:answers, :superuser],
            :answers_translator => [:answers, :translator]
          }
          mappings[roles.first] || roles
        end
      end
    end
  end
end
