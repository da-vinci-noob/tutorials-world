class Tutorial < ApplicationRecord
  belongs_to :language
  belongs_to :user

  def isOpen
    false
  end
end
