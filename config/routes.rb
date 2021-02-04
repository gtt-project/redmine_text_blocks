resources :text_blocks, only: %i(index new create edit update destroy)

scope 'projects/:project_id' do
  resources :text_blocks, only: %i(new create edit update destroy),
                          as: :project_text_blocks
end

get "text_blocks_by_status/:status_id/:project_id", to: "text_blocks#blocks_by_status", defaults: {format: "json"}
