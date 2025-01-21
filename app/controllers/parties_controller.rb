class PartiesController < ApplicationController
  before_action :result, only: %i[ show ]
  def index
    @parties_list = Parties.all["dados"]

    @party_selected_acronym = params[:party_acronym]
    @party_selected_id = params[:party_id]
  end
  def show
    @result_page_data
  end

  private

  def result_page_data(client, option)
    @result_page_data ||= client.search(option)
  end
  def research_filter_func(client, option, initial_date = nil)
    result_page_data(client, option).nil? ? (redirect_to request.fullpath) : result_page_data(client, option)
  end
  def result
    options = params[:party_acronym]
    id = params[:party_id]

    @parties_research = { id: id, options: options }
    client = ClientPartiesResearch

    research_filter_func(client, @parties_research)
  end
end
