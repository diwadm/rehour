require 'dropdown_helper'

class Customer < ActiveRecord::Base
  include DropdownHelper
  
  validates_presence_of :name
  validates_presence_of :code
  
  validates_length_of :name, :in => 3..255
  validates_length_of :code, :in => 2..5
  
  has_many :projects, :dependent => :destroy
  
  default_scope :order => 'name ASC'
  
  def active
    self.is_active ? 'Yes' : 'No'
  end
end
