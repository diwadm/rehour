require 'dropdown_helper'

class Department < ActiveRecord::Base
  include DropdownHelper
  
  validates_presence_of :name
  validates_presence_of :code
  
  validates_length_of :name, :in => 3..255
  validates_length_of :code, :in => 2..64
  
  has_many :users, :dependent => :destroy
  
  default_scope :order => 'name ASC'
end
