class Role < ActiveRecord::Base
  has_many :interactions
end
