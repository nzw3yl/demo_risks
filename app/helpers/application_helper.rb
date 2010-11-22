module ApplicationHelper

 def logo
    image_tag("logo.png", :alt => "Risks & Priorities", :class => "round")
 end

 def title
    base_title = "Risks & Priorities"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end 
 end
end
