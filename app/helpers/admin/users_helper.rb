module Admin::UsersHelper
  def is_active_form_column(record, input_name)
	  check_box :record, :is_active, {}, true
	end
	
	def password_form_column(record, input_name)
	  record.password = nil
	  password_field :record, :password
	end
	
	def password_confirmation_form_column(record, input_name)
	  password_field :record, :password_confirmation
	end
	
	def department_id_form_column(record, input_name)
	  select_options_tag('record[department_id]', Department.new.dropdown, :values => record.department_id)
	end
end
