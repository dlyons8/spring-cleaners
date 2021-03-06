class Customer < ApplicationRecord
    validates :first_name, :last_name, :address, :phone, presence: true
    validates :first_name, :last_name, length: { minimum: 2 }
   
    belongs_to :user
    has_many :appointments, dependent: :destroy
    has_many :cleaners, through: :appointments

    delegate :email, :password_digest, :to => :user

    def full_name
        "#{first_name} #{last_name}"
    end

    def location
        "#{address["neighborhood"]}, #{address["city"]}"
    end

    def full_location
        "#{address["street_address"]}, #{address["neighborhood"]}, #{address["city"]}"
    end

end