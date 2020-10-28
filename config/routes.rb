Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'questions', to: 'questions#questions'
  get 'question/:id', to: 'questions#question'
end
