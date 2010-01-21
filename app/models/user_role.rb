require 'dropdown_helper'

class UserRole < ActiveRecord::Base
  include DropdownHelper
  
  validates_presence_of :name
end
