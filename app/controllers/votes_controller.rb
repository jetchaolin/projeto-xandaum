class VotesController < ApplicationController
  before_action :result, only: %i[ show ]
  def index
    @vote_option_subject = [
      "votacoes",
      "orientacoes",
      "votos"
    ]
    @vote_selected_id = params[:vote_id]
    if (params[:initial_date] || params[:final_date]).present?
      @initial_date = params[:initial_date] || nil
      @final_date = params[:final_date] || nil
      @votes_list = Votes.by_date(@initial_date, @final_date)["dados"]
      if @votes_list.nil?
        @votes_list = Votes.all["dados"]
        if @votes_list.nil?
          @votes_list = { dados: [ { id: "1" }, { descricao: "Não foi possível encontrar" } ] }.to_json
        end
      end
    else
      @votes_list = Votes.all["dados"]
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
      redirect_to edit_path(option)
    end
  end
  def result
    @date_selector = [
      "votacoes",
      "orientacoes",
      "votos"
    ]
    options = params[:vote_options]
    id = params[:vote_id]

    @votes_research = { id: id, options: options }
    client = ClientVotesResearch

    research_filter_func(client, @votes_research)
  end
end
