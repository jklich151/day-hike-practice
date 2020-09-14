class Trip < ApplicationRecord
  belongs_to :visitor
  has_many :trail_trips
  has_many :trails, through: :trail_trips

  def total_distance
    trails.sum(:length)
  end

  def average_distance
    trails.average(:length)
  end

  def longest_trail
    trails.order(:length).last
  end

  def shortest_trail
    trails.order(:length).first
  end
end
