module ApplicationHelper
	def flash_message flash
  	return flash.to_hash.values.join(", ")
  end
end
