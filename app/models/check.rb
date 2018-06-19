class Check < ApplicationRecord
  belongs_to :user

  has_many :vulnerabilities
end
