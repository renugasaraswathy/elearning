module ApplicationHelper
	def flash_message
		if flash[:notice]
			"<div class='alert alert-success alert-dismissable'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{flash[:notice]}</div>".html_safe
		elsif flash[:error]
			"<div class='alert alert-warning alert-dismissable'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{flash[:error]}</div>".html_safe
		end
	end

	def active_class(controller,link)		
			if controller==link
				"active"
			end		
	end
end
