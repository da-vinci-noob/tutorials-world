class Tutorial < ApplicationRecord
  belongs_to :language

  def isOpen
    false
  end
end
