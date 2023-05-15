class Plan < ApplicationRecord
  validates :plan, presence: true
  validates :date, presence: true

  has_many :plans
  belongs to :date
end
