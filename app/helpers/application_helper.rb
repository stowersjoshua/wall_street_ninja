module ApplicationHelper # :nodoc:
  def flash_message(flash)
    flash.to_hash.values.join(', ')
  end
end
