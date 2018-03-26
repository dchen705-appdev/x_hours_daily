class Category < ApplicationRecord
  # Direct associations

  has_many   :tasks,
             :dependent => :nullify

  belongs_to :user,
             :counter_cache => true

  # Indirect associations

  # Validations
validates :name, :presence => true, :uniqueness => { :scope => :user }

end
