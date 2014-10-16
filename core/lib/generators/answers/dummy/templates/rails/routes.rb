Rails.application.routes.draw do
  mount Answers::Core::Engine, at: '/'
end
