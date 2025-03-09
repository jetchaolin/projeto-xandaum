class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private
    
  def result_page_data(client, option)
    @result_page_data ||= client.search(option)
  end

  def research_filter_func(client, option, initial_date = nil)
    search = option[:options]
    if @date_selector.include?(search)
      result_page_data(client, option).nil? ? (redirect_to request.fullpath) : result_page_data(client, option)
    elsif (params[:initial_date] || params[:final_date]).present?
      date = [ params[:initial_date], params[:final_date] ]

      option[:initial_date] = (date[0] || nil)
      option[:final_date] = (date[1] || nil)
      result_page_data(client, option).nil? ? (redirect_to request.fullpath) : result_page_data(client, option)
    else
      redirect_to edit_deputy_path(option)
    end
  end
end
