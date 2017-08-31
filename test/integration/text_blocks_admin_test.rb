require_relative '../test_helper'

class TextBlocksAdminTest < Redmine::IntegrationTest
  fixtures :users, :email_addresses, :user_preferences

  def setup
    super
    User.current = nil
  end

  def test_textblocks_require_admin
    get '/text_blocks'
    assert_response :redirect
  end

  def test_textblock_crud
    log_user 'admin', 'admin'

    get '/text_blocks'
    assert_response :success

    get '/text_blocks/new'
    assert_response :success

    assert_difference 'TextBlock.count' do
      post '/text_blocks', params: { text_block: { name: 'test', text: 'lorem ipsum'}}
    end
    assert_redirected_to '/text_blocks'

    follow_redirect!

    assert b = TextBlock.find_by_name('test')
    assert_equal 'lorem ipsum', b.text

    get "/text_blocks/#{b.id}/edit"
    assert_response :success

    patch "/text_blocks/#{b.id}", params: { text_block: { name: 'new' } }
    b.reload
    assert_equal 'lorem ipsum', b.text
    assert_equal 'new', b.name

    assert_difference 'TextBlock.count', -1 do
      delete "/text_blocks/#{b.id}"
    end
    assert_redirected_to '/text_blocks'

  end
end
