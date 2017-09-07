require 'redmine'

Rails.configuration.to_prepare do
  RedmineTextBlocks.setup
end

Redmine::Plugin.register :redmine_text_blocks do
  name 'Redmine Text Blocks Plugin'
  author 'Jens Krämer, Georepublic'
  author_url 'https://hub.georepublic.net/gtt/redmine_text_blocks'
  description 'Adds configurable text blocks for replying to issues'
  version '0.1.0'

  requires_redmine version_or_higher: '3.4.0'

  #settings default: {
  #}, partial: 'redmine_text_blocks/settings'

  project_module :text_blocks do

    permission :view_text_blocks, {}, require: :member, read: true
    permission :manage_text_blocks, {
      text_blocks: %i( new edit update create destroy ),
      projects: %i( manage_text_blocks )
    }, require: :member
  end

  menu :admin_menu, :text_blocks,
    { controller: 'text_blocks', action: 'index' },
    caption: :label_text_block_plural, :html => {:class => 'icon'}

end

