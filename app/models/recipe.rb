class Recipe < ApplicationRecord
  include ConstantValidatable

  include Filterable

  # jitera-anchor-dont-touch: relations

  has_many :ingredients, dependent: :destroy

  has_many :ratings, dependent: :destroy

  belongs_to :category

  belongs_to :user

  # jitera-anchor-dont-touch: enum
  enum difficulty: %w[easy normal challenging], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('.out_of_range_error') },
                           presence: true

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  scope :filter_by_title, -> (title) { where("LOWER(title) LIKE ?", "%#{title.downcase}%") }

  scope :filter_by_min_time, -> (min_time) { where("CAST(time AS UNSIGNED) >= ?", min_time.to_i) }

  scope :filter_by_max_time, -> (max_time) { where("CAST(time AS UNSIGNED) <= ?", max_time.to_i) }

  scope :filter_by_difficulty, -> (difficulty) { where("difficulty = ?", difficulty.to_i) }

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
