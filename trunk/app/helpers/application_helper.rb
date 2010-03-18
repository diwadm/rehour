# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def app_name
    "reHour"
  end
  
  def version_number
    "0.1.2"
  end
  
  
  
  def assets_prefix
    ''
    #'kmh/'
  end
  
  def calendar_prefix
    'calendar/blue/'
    #'kmh/'
  end
  
  def select_options_tag(name='',select_options={},options={})
    #set selected from value
    selected = ''
    unless options[:value].blank?
      selected = options[:value]
      options.delete(:value)
    end
    
    selected = options[:values] if options[:values]
    
    select_tag(name,options_for_select(select_options,selected),options)
  end
  
  def currency_format(money)
    number_to_currency(money, :unit => '$ ')
  end
  
  def number_format(number)
    number_with_precision(number, 2) if number
  end
  
  def date_format(time = Time.now)
    time.strftime('%b %d, %Y') if time != nil
  end
  
  def date_time_format(time = Time.now)
    time.strftime('%b %d %Y, %I:%m %p')
  end
  
  def day_date_only(time = Time.now)
    time.strftime('%a %d')
  end
  
  def admin_default_link(link_name)
    link_to(link_name, :controller => 'admin/users')
  end
end
