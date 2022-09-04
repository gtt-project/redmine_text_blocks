module RedmineTextBlocks
  class SaveTextBlock

    Result = ImmutableStruct.new :text_block_saved?, :text_block

    def self.call(*args, **kwargs)
      new(*args, **kwargs).call
    end

    def initialize(params, text_block: TextBlock.new,
                           project: text_block.project)
      @params = params
      @text_block = text_block
      @project = project
    end


    def call
      @text_block.project = @project
      @text_block.attributes = @params

      return Result.new text_block_saved: @text_block.save,
                        text_block: @text_block
    end
  end
end
