class TextBlock < ActiveRecord::Base
  belongs_to :project
  has_and_belongs_to_many :issue_statuses
  acts_as_positioned :scope => [:project_id]

  validates :name, presence: true
  validate :name_uniqueness
  validates_numericality_of :position, :only_integer => true
  before_create :set_position

  scope :sorted, ->{ order(Arel.sql('project_id IS NOT NULL, project_id ASC, position ASC')) }

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

  def set_position
    if project_id.present?
      max = self.class.where(:project_id => project_id).maximum(:position) || 0
      self.position = max + 1
    else
      max = self.class.where(:project_id => nil).maximum(:position) || 0
      self.position = max + 1
    end
  end
end
