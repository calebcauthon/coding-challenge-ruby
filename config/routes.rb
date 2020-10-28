Rails.application.routes.draw do
  root 'welcome#index'

  get 'welcome/index'
  get 'application/questions'
  get 'application/question/:id', to: 'application#question'
end
