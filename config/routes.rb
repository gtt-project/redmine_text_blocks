resources :text_blocks, only: %i(index new create edit update destroy)

scope 'projects/:project_id' do
  resources :text_blocks, only: %i(index new create edit update destroy),
                          as: :project_text_blocks
end
