module DropdownHelper
  def dropdown(conditions = ['1'], order = 'name')
    items = [['-- select --', nil]]
    for item in eval(self.class.to_s).send(:find, :all, :order => order, :conditions => conditions)
      items << [item.name, item.id]
    end
  
    items
  end
end