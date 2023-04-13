class Exercise < ApplicationRecord
    validates :name, presence: true
    validates :mets_high, presence: true
    validates :mets_middle, presence: true
    validates :mets_low, presence: true
end
