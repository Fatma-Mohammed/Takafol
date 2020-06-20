class Charity < ApplicationRecord

  scope :verified, -> { where("verified = 1") }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name , presence: true
         validates :email, email_format: { message: 'Invalid email format' } , confirmation: true
         validates :phone_number, format: { with: /\A[+-]?\d+\z/ , message:  "Phone must only contain Numbers." } , uniqueness: true

  has_many :charities_cases
  has_many :cases, through: :charities_cases
  belongs_to :city
  accepts_nested_attributes_for :cases

end
