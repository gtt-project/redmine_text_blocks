require_relative '../test_helper'

class TextBlockTest < ActiveSupport::TestCase
  fixtures :projects

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
end

