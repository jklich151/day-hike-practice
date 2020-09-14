class AddVisitorsToTrips < ActiveRecord::Migration[5.1]
  def change
    add_reference :trips, :visitor, foreign_key: true
  end
end
