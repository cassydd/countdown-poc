class CountdownImageDescriptor < ActiveRecord::Base
  validates :name, uniqueness: true
end
