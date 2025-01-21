module ApplicationHelper
  def render_value(value)
    if value.is_a?(String) && value.start_with?("http")
      if (value.include?("youtube.com") || value.include?("youtu.be")) && !value.include?("/@") && !value.include?("channel")
        render_youtube_video(value)
      elsif value.include?("instagram") || value.include?("twitter") || value.include?("facebook") || value.include?("linkedin") || value.include?("x.com") || value.include?("youtube")
        link_to("#{value}", value)
      elsif value.end_with?(".jpeg", ".jpg", ".png")
        image_tag(value, size: "100x100")
      elsif value.end_with?("gif")
        image_tag(value, size: "100x50")
      else
        link_to("Link", value)
      end
    else
      value
    end
  end
  def render_hash_value(value)
    if value.is_a?(Hash)
      value.map do |key, sub_value|
        content_tag(:table, border: 1) do
          content_tag(:tr) do
            content_tag(:td, (key.capitalize + "&nbsp;").html_safe) +
            content_tag(:td) do
              if sub_value.is_a?(Hash)
                sub_value.map do |sub_key, sub_sub_value|
                  content_tag(:table, border: 1) do
                    content_tag(:tr) do
                      content_tag(:td, (sub_key.capitalize + "&nbsp;").html_safe) +
                      if sub_sub_value.is_a?(Hash)
                        sub_sub_value.map do |sub_sub_key, sub_sub_sub_value|
                          content_tag(:td, (sub_sub_key.capitalize + "&nbsp;").html_safe) +
                          content_tag(:td, ("&nbsp;".html_safe + render_value(sub_sub_sub_value)))
                        end.join.html_safe
                      else
                        content_tag(:td, render_value(sub_sub_value))
                      end
                    end
                  end
                end.join.html_safe
              else
                content_tag(:td, render_value(sub_value))
              end
            end
          end
        end
      end.join.html_safe
    elsif value.is_a?(Array)
      value.map do |item|
        content_tag(:table, border: 1) do
          content_tag(:tr) do
            item.map do |sub_key, sub_item|
              content_tag(:td) do
                content_tag(:span, (sub_key.to_s).capitalize + ": ") +
                content_tag(:span, render_value(sub_item))
              end
            end.join.html_safe
          end
        end
      end.join.html_safe
    else
      render_value(value)
    end
  end
  def value_identifier(key, value)
    if value.is_a?(Hash)
      content_tag(:tr) do
        content_tag(:th, content_tag(:strong, (key.to_s).capitalize)) +
        content_tag(:th, parse_hash(value))
      end
    elsif value.is_a?(Array) && !value[0].is_a?(Hash)
      content_tag(:tr) do
        content_tag(:th, content_tag(:strong, (key.to_s).capitalize)) +
        content_tag(:th, parse_array_with_no_hash(value))
      end
    elsif value.is_a?(Array) && value.size <= 1
      content_tag(:tr) do
        content_tag(:th, content_tag(:strong, (key.to_s).capitalize)) +
        content_tag(:th, parse_array_with_single_hash(value))
      end
    elsif value.is_a?(Array) && value.size >= 2
      content_tag(:tr) do
        content_tag(:th, content_tag(:strong, (key.to_s).capitalize)) +
        content_tag(:th, parse_array_with_multiple_hashes(value))
      end
    else
      content_tag(:tr) do
        content_tag(:td, content_tag(:strong, (key.to_s).capitalize)) +
        content_tag(:td, render_value(value))
      end
    end
  end
  def parse_hash(value)
    value.map do |key, sub_value|
      content_tag(:table, border: 1) do
        content_tag(:tr) do
          content_tag(:td, (key.capitalize + "&nbsp;").html_safe) +
          if sub_value.is_a?(Hash)
            sub_value.map do |sub_key, sub_sub_value|
              content_tag(:td, (sub_key.capitalize + "&nbsp;").html_safe) +
              content_tag(:td, ("&nbsp;".html_safe + render_value(sub_sub_value)))
            end.join.html_safe
          else
            content_tag(:td, render_value(sub_value))
          end
        end
      end
    end.join.html_safe
  end
  def parse_array_with_single_hash(value)
    value.map do |item|
      content_tag(:table, border: 1) do
        content_tag(:tr) do
          item.map do |key, sub_value|
            content_tag(:td) do
              content_tag(:span, key.capitalize + ": ") +
              content_tag(:span, render_value(sub_value))
            end
          end.join.html_safe
        end
      end
    end.join.html_safe
  end
  def parse_array_with_no_hash(value)
    value.map do |item|
      content_tag(:table, border: 1) do
        content_tag(:tr) do
          content_tag(:td) do
            content_tag(:span, render_value(item))
          end
        end
      end
    end.join.html_safe
  end
  def parse_array_with_multiple_hashes(value)
    value.map do |item|
      content_tag(:table, border: 1) do
        content_tag(:tr) do
          item.map do |sub_key, sub_item|
            content_tag(:td) do
              content_tag(:span, (sub_key.to_s).capitalize + ": ") +
              content_tag(:span, render_value(sub_item))
            end
          end.join.html_safe
        end
      end
    end.join.html_safe
  end
  def render_youtube_video(url)
    content_tag(:iframe, nil, width: 480, height: 240, src: url.gsub("watch?v=", "embed/"), frameborder: 0, allowfullscreen: true)
  end
  def turbo_helper
    if request.url == "http://localhost:3000/home/votes"
      "votes_list"
    elsif request.url == "http://localhost:3000/home/events"
      "events_list"
    end
  end
end
