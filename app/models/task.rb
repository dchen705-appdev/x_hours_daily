class Task < ApplicationRecord
  # Direct associations

  belongs_to :category,
             :required => false,
             :counter_cache => true

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
