class Appointment < ApplicationRecord
    validates :date, :time_slot,  presence: true
    
    belongs_to :cleaner, optional: true
    belongs_to :customer

    scope :all_pending, -> { where(cleaner_id: nil) }

    STATUS = ["Pending","Confirmed", "Completed"]

    delegate :location, :to => :customer
    delegate :full_location, :to => :customer

end
