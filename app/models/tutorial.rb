class Tutorial < ApplicationRecord
  belongs_to :language
  belongs_to :user

  validates :title, presence: { message: "Can't be blank" }
  validates :body, presence: { message: "Can't be blank" }

  # Default Ordering for the Tasks
  default_scope { order(:title) }

  def isOpen
    false
  end
end
