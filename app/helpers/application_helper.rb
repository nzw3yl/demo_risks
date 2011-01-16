module ApplicationHelper

 def logo
    image_tag("logo.gif", :alt => "Workload Manager", :class => "round", :width => "45", :height => "45")
 end
  
 def icon(action, size = 16)
   @icon_name = action + "-icon.png"
   @alt_text = action.capitalize
   image_tag(@icon_name, :alt => @alt_text, :class => "round", :width => size, :height => size)
 end

 def title
    base_title = "Workload Manager"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end 
 end

 def sortable(column, title = nil)
   title ||= column.titleize
   css_class = column == sort_column ? "current #{sort_direction}" : nil
   direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
   link_to title, {:sort => column, :direction => direction}, {:class => css_class}
 end
end
