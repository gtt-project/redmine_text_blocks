require_relative '../test_helper'

class TextBlocksProjectTest < Redmine::IntegrationTest
  fixtures :users, :email_addresses, :user_preferences,
    :roles, :projects, :members, :member_roles

  def setup
    super
    User.current = nil
    @project = Project.find 'ecookbook'
    EnabledModule.delete_all
    EnabledModule.create! project: @project, name: 'text_blocks'
  end

  def test_textblocks_require_permission
    log_user 'jsmith', 'jsmith'

    get '/projects/ecookbook/settings'
    assert_response :success
    assert_select 'li a', text: 'Text blocks', count: 0
    post '/projects/ecookbook/text_blocks', params: { text_block: { name: 'new' }}
    assert_response 403
  end

  def test_textblock_crud
    Role.find(1).add_permission! :manage_text_blocks

    log_user 'jsmith', 'jsmith'

    get '/projects/ecookbook/settings'
    assert_select 'li a', text: 'Text blocks'

    get '/projects/ecookbook/settings/text_blocks'
    assert_response :success

    get '/projects/ecookbook/text_blocks/new'
    assert_response :success

    assert_difference 'TextBlock.count' do
      post '/projects/ecookbook/text_blocks', params: { text_block: { name: 'test', text: 'lorem ipsum'}}
    end
    assert_redirected_to '/projects/ecookbook/settings/text_blocks'

    follow_redirect!

    assert b = TextBlock.find_by_name('test')
    assert_equal 'lorem ipsum', b.text

    get "/projects/ecookbook/text_blocks/#{b.id}/edit"
    assert_response :success

    patch "/projects/ecookbook/text_blocks/#{b.id}", params: { text_block: { name: 'new' } }
    b.reload
    assert_equal 'lorem ipsum', b.text
    assert_equal 'new', b.name

    assert_difference 'TextBlock.count', -1 do
      delete "/projects/ecookbook/text_blocks/#{b.id}"
    end
    assert_redirected_to '/projects/ecookbook/settings/text_blocks'
  end
end
