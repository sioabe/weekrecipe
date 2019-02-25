class List < ApplicationRecord
  belongs_to :user
  validates :list_name, presence: true
  has_many :list_recipes , dependent: :destroy
end
