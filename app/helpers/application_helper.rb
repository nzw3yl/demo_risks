module ApplicationHelper

 def logo
    image_tag("logo.gif", :alt => "Workload Manager", :class => "round", :width => "45", :height => "45")
 end

 def title
    base_title = "Workload Manager"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end 
 end
end
