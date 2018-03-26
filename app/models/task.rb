class Task < ApplicationRecord
  # Direct associations

  belongs_to :category,
             :required => false,
             :counter_cache => true

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations
  validates :name, :presence => true

  validates :deadline, :future => true #future validator checks if deadline is valid date (invalids= blanks and inputs that Chronic can't parse) and checks if date is in future
  validates :status, :presence => true
  
end
