class Category < ApplicationRecord
  # Direct associations

  has_many   :tasks,
             :dependent => :nullify

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations

end
