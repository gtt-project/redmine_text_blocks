require_relative '../test_helper'

class TextBlockTest < ActiveSupport::TestCase
  fixtures :projects, :issue_statuses

  setup do
    @project = Project.find 'ecookbook'
  end

  test 'should require name' do
    r = RedmineTextBlocks::SaveTextBlock.({})
    refute r.text_block_saved?
    assert r.text_block.errors[:name]
  end

  test 'should validate name uniqueness against global text block' do
    assert_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'})
      assert r.text_block_saved?
      assert_equal 'test', r.text_block.name
    end

    assert_no_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'})
      refute r.text_block_saved?
      assert r.text_block.errors[:name]
    end

    assert_no_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'}, project: @project)
      refute r.text_block_saved?
      assert r.text_block.errors[:name]
    end
  end

  test 'should validate name uniqueness against local text block' do
    assert_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'}, project: @project)
      assert r.text_block_saved?
      assert_equal 'test', r.text_block.name
    end

    assert_no_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'})
      refute r.text_block_saved?
      assert r.text_block.errors[:name]
    end

    project = Project.find 'onlinestore'
    assert_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.({name: 'test'}, project: project)
      assert r.text_block_saved?
      assert_equal 'test', r.text_block.name
      assert_equal project, r.text_block.project
    end
  end

  test 'should save params in global text block' do
    assert_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.(
        {
          name: 'test',
          text: 'lorem ipsum',
          issue_status_ids: [1, 2]
        }
      )
      assert r.text_block_saved?
      assert_equal 'test', r.text_block.name
      assert_equal 'lorem ipsum', r.text_block.text
      assert_equal [1, 2], r.text_block.issue_status_ids.sort
      assert_equal 1, r.text_block.position
    end
  end

  test 'should save params in local text block' do
    assert_difference 'TextBlock.count' do
      r = RedmineTextBlocks::SaveTextBlock.(
        {
          name: 'test',
          text: 'lorem ipsum',
          issue_status_ids: [1, 2]
        },
        project: @project
      )
      assert r.text_block_saved?
      assert_equal 'test', r.text_block.name
      assert_equal 'lorem ipsum', r.text_block.text
      assert_equal [1, 2], r.text_block.issue_status_ids.sort
      assert_equal 1, r.text_block.position
    end
  end

  test 'deletion of project should delete textblocks' do
    RedmineTextBlocks::SaveTextBlock.({name: 'test'}, project: @project)
    assert_difference 'TextBlock.count', -1 do
      @project.destroy
    end
  end
end

