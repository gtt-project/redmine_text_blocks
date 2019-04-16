class TextBlock < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :issue_statuses

  validates :name, presence: true
  validate :name_uniqueness


  private

  def name_uniqueness
    scope = TextBlock.where.not(id: id).where(name: name)

    if project_id.present?
      scope = scope.where project_id: [ nil, project_id ]
    end

    if scope.any?
      errors.add :name, I18n.t('model.text_block.name_uniqueness')
    end
  end

end
