class Employee < ActiveRecord::Base
  belongs_to :department
  has_and_belongs_to_many :skills
  
  validates :name, presence: true, length: { minimum: 4, maximum: 50 }, uniqueness: true
end
