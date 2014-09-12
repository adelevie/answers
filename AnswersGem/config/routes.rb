AnswersGem::Engine.routes.draw do
  get "/", controller: "foos", action: :index
end
