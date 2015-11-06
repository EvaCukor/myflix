module ApplicationHelper
  def options_for_video_reviews(selected = nil)
    options_for_select([5, 4, 3, 2, 1].map {|number| [pluralize(number, 'Star'), number]}, selected)
  end
  
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"   # Green
      when "error"
        "alert-danger"    # Red
      when "alert"
        "alert-warning"   # Yellow
      when "notice"
        "alert-info"      # Blue
      else
        flash_type.to_s
    end
  end
end