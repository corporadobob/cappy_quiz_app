CapybaraApp::Application.routes.draw do
  root to: 'welcome#index'

  get "/javascript" => "welcome#javascript"
  get "/quizzes" => "welcome#quizzes"

end
