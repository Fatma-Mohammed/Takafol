class DonorsCase < ApplicationRecord
    belongs_to :donor
    belongs_to :case
    paginates_per 25
end
