module Admin::ProjectsHelper
  def is_active_form_column(record, input_name)
	  check_box :record, :is_active, {}, true
	end
	
	def is_billable_form_column(record, input_name)
	  check_box :record, :is_billable, {}, true
	end
	
	def is_default_form_column(record, input_name)
	  check_box :record, :is_default, {}, true
	end
	
	def customer_id_form_column(record, input_name)
	  select_options_tag('record[customer_id]', Customer.new.dropdown, :value => record.customer_id)
	end
end
