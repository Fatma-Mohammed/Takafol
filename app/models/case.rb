class Case < ApplicationRecord

    before_validation :normalize_blank_values

    scope :verified, -> { joins(:charities_cases).joins(:charities).where("charities_cases.state = 'protected'") }

    require 'carrierwave/orm/activerecord'
    mount_uploader :NID_img, NidUploader
    attr_accessor :perform_image_validation
    paginates_per 15
    validates :name , presence: true
    validates :job , presence: true
    validates :email, email_format: { message: 'Invalid email format' } , allow_nil: true, uniqueness: false, presence: false
    validates :national_id, format: { with: /\A[+-]?\d+\z/ , message:  "National Id must only contain Numbers." } , uniqueness: true , length: { is: 14  }
    validates :NID_img , presence:  {message:  "you have to upload a National Id image" } , if: :perform_image_validation
    validates :children_num, :inclusion => { :in => 0..20 }
    validates :marital_status , presence: true, inclusion: { in: %w(Married Divorced Single), message: 'marital status is not defined'}
    validates :phone, format: { with: /\A[+-]?\d+\z/ , message:  "Phone must only contain Numbers." } , uniqueness: false
    validates :priority, :inclusion => { :in => 1..5 } , allow_nil: true



    #charity&case relation
    has_many :charities_cases
    has_many :charities, through: :charities_cases
    accepts_nested_attributes_for :charities


    # doner&case relation
    has_many :donors_cases
    has_many :donors, through: :donors_cases
    belongs_to :city

    # convert empty values to nil
    def normalize_blank_values
        attributes.each do |column, value|
            self[column].present? || self[column] = nil
        end
    end

end
