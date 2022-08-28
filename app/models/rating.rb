class Rating < ApplicationRecord
  belongs_to :user

  belongs_to :recipe

  validates :score, presence: true

  validates_inclusion_of :score, in: 1..5

  validates :recipe, uniqueness: { scope: :user }, if: -> { new_record? }
end
