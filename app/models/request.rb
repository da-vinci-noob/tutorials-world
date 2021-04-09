class Request < ApplicationRecord
  enum type_of_request: { language: 0, feedback: 1 }
  validates :type_of_request, presence: true
  validates :body, presence: true

  belongs_to :user
end
