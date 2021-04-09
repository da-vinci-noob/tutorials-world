class Tutorial < ApplicationRecord
  belongs_to :language
  belongs_to :user

  # validates :language, presence: true
  # validates :user, presence: true

  # Default Ordering for the Tasks
  default_scope { order(:title) }

  def isOpen
    false
  end
end
