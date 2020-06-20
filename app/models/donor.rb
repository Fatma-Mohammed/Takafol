class Donor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :national_id, uniqueness: true
         has_many :donors_cases
         has_many :cases, through: :donors_cases

  validates :national_id, format: { with: /\A[+-]?\d+\z/ , message:  "National Id must only contain Numbers." } , uniqueness: true , length: { is: 14 }

  validates :name , presence: true ,  format: { with: /\A[a-z\s]+\Z/i, message:  "Name must only contain letters." }
end
