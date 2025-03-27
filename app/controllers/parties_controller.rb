class PartiesController < ApplicationController
  before_action :result, only: %i[ show ]
  SUBJECT = "partidos".freeze
  CACHE_KEY = "parties_all".freeze
  EXPIRING_TIME = 3.days
  PARAMS = { itens: 100 }
  def index
    @parties_list = Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME, PARAMS)["dados"]
    @party_selected_acronym = params[:party_acronym]
    @party_selected_id = params[:party_id]
  end
  def show
    @result_page_data
  end

  private

  def research_party_func(client, option, initial_date = nil)
    result_page_data(client, option).nil? ? (redirect_to request.fullpath) : result_page_data(client, option)
  end
  def result
    party_id = params[:party_id]
    options = params[:party_acronym]
    @parties_research = { id: party_id, options: options }

    research_party_func(ClientPartiesResearch, @parties_research)
  end
end
