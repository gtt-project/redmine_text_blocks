require_relative '../test_helper'

class TextBlocksAdminTest < Redmine::IntegrationTest
  fixtures :users, :email_addresses, :user_preferences, :issue_statuses

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
      post '/text_blocks', params: {
        text_block: { name: 'test', text: 'lorem ipsum', issue_status_ids: [1, 2] }
      }
    end
    assert_redirected_to '/text_blocks'

    follow_redirect!

    assert b = TextBlock.find_by_name('test')
    assert_equal 'lorem ipsum', b.text
    assert_equal [1, 2], b.issue_statuses.map(&:id).sort
    assert_equal 1, b.position

    get "/text_blocks/#{b.id}/edit"
    assert_response :success

    patch "/text_blocks/#{b.id}", params: { text_block: { name: 'new' } }
    b.reload
    assert_equal 'lorem ipsum', b.text
    assert_equal 'new', b.name

    assert_difference 'TextBlock.count' do
      post '/text_blocks', params: {
        text_block: { name: 'test2', text: 'lorem ipsum2', issue_status_ids: [1, 2] }
      }
    end
    assert_redirected_to '/text_blocks'

    follow_redirect!

    assert b = TextBlock.find_by_name('test2')
    assert_equal 'lorem ipsum2', b.text
    assert_equal [1, 2], b.issue_statuses.map(&:id).sort
    assert_equal 2, b.position

    assert_difference 'TextBlock.count', -1 do
      delete "/text_blocks/#{b.id}"
    end
    assert_redirected_to '/text_blocks'

  end
end
