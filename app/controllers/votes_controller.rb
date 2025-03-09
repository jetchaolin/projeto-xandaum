class VotesController < ApplicationController
  before_action :result, only: %i[ show ]
  SUBJECT = "votacoes".freeze
  CACHE_KEY = "votes_all".freeze
  EXPIRING_TIME = 5.days
  DROP_LIST = [
    "votacoes",
    "orientacoes",
    "votos"
  ].freeze
  def index
    @vote_option_subject = DROP_LIST
    @vote_selected_id = params[:vote_id]
    if (params[:initial_date] || params[:final_date]).present?
      @initial_date = params[:initial_date] || nil
      @final_date = params[:final_date] || nil
      @votes_list = Service::FetchList.by_date(SUBJECT, CACHE_KEY, EXPIRING_TIME, @initial_date, @final_date)["dados"]
      if @votes_list.nil?
        @votes_list = Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME)["dados"]
        if @votes_list.nil?
          @votes_list = { dados: [ { id: "1" }, { descricao: "Não foi possível encontrar" } ] }.to_json
        end
      end
    else
      @votes_list = Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME)["dados"]
    end
  end
  def show
    @result_page_data
  end
  def date_select
    @vote_selected_id = params[:vote_id]
    @vote_selected_option = params[:options]
  end

  private

  def result
    @date_selector = DROP_LIST
    vote_id = params[:vote_id]
    options = params[:vote_options]

    @votes_research = { id: vote_id, options: options }

    research_filter_func(ClientVotesResearch, @votes_research)
  end
end
