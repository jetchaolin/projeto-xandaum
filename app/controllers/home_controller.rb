class HomeController < ApplicationController
  before_action :result, only: %i[ show ]
  def index
  end
  def date_select
    if params[:name].present?
      @deputies_research_subject = [
        "deputado",
        "despesas",
        "discursos",
        "eventos",
        "frentes",
        "profissoes",
        "lideres",
        "mandatosExternos",
        "historico",
        "mesa",
        "orgaos",
        "ocupacoes"
      ]
      @deputy_selected_name = params[:name]
      @deputy_selected_research = params[:options]
      @deputy_selected_id = params[:id]
    elsif params[:option].present?
      @event_option_subject = [
        "eventos",
        "deputados",
        "orgaos",
        "pauta",
        "votacoes",
        "situacoesEvento",
        "tiposEvento",
        "codSituacaoEvento",
        "codTipoEvento"
      ]
      @event_selected_id = params[:event_id]
      @event_selected_option = params[:options]
    else
      @vote_option_subject = [
        "votacoes",
        "orientacoes",
        "votos"
    ]
    @vote_selected_id = params[:vote_id]
    @vote_selected_option = params[:options]
    end
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
      redirect_to home_date_select_path(option)
    end
  end
  def result
    if params[:name].present?
      @date_selector = [
        "deputado",
        "despesas",
        "frentes",
        "historico",
        "mandatosExternos",
        "ocupacoes",
        "profissoes",
        "lideres",
        "codSituacao",
        "situacoesDeputado"
      ]
      name = params[:name]
      research = (params[:research] || params[:options])
      id = params[:id]

      @deputies_research = { name: name, id: id, options: research }
      client = ClientDeputiesResearch

      research_filter_func(client, @deputies_research)
    elsif params[:options].present?
      @date_selector = [
        "eventos",
        "deputados",
        "orgaos",
        "pauta",
        "votacoes",
        "situacoesEvento",
        "tiposEvento",
        "codSituacaoEvento",
        "codTipoEvento"
      ]
      options = params[:options]
      id = params[:event_id]

      @event_research = { id: id, options: options }
      client = ClientEventsResearch

      research_filter_func(client, @event_research)
    elsif params[:vote_options].present?
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
    else
      acronym = params[:party_acronym]
      id = params[:party_id]

      @parties_research = { id: id, acronym: acronym }

      result_page_data(ClientPartiesResearch, @parties_research).nil? ? (redirect_to home_parties_list_path) : result_page_data(ClientPartiesResearch, @parties_research)
    end
  end
end
