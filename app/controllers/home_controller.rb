class HomeController < ApplicationController
  before_action :result, only: %i[ show ]
  # before_action :date_result, only: %i[ show ]
  def main
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
    @deputy_selected_name = params[:deputy_name]
    @deputy_selected_id = params[:deputy_id]

    @event_option_subject = [
      "eventos",
      "deputados",
      "orgaos",
      "pauta",
      "votacoes",
      "situacoesEvento",
      "tiposEvento"
    ]
    @event_selected_id = params[:event_id]
  end
  def index
    @deputies_list = Deputies.all["dados"]
  end
  def detailed_events_list
    @events_list = Events.all["dados"]
  end
  def parties_list
    @parties_list = Parties.all["dados"]

    @party_selected_acronym = params[:party_acronym]
    @party_selected_id = params[:party_id]
  end
  def show
    @result_page_data
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
      @deputy_selected_research = params[:research]
      @deputy_selected_id = params[:id]
    else
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
    end
  end

  private

  def result_page_data_func(client, option)
    @result_page_data = client.search(option)
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
      research = params[:research]
      id = params[:id]

      @deputies_research = { name: name, id: id, research: research }

      if @date_selector.include?(research)
        result_page_data_func(ClientDeputiesResearch, @deputies_research).nil? ? (redirect_to home_index_path) : result_page_data_func(ClientDeputiesResearch, @deputies_research)
      elsif params[:initial_date].present?
        date = params[:initial_date]

        @deputies_research[:initial_date] = date
        result_page_data_func(ClientDeputiesResearch, @deputies_research).nil? ? (redirect_to home_index_path) : result_page_data_func(ClientDeputiesResearch, @deputies_research)
      else
        redirect_to home_date_select_path(@deputies_research)
      end
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

      if @date_selector.include?(options)
        result_page_data_func(ClientEventResearch, @event_research).nil? ? (redirect_to home_detailed_events_list_path) : result_page_data_func(ClientEventResearch, @event_research)
      elsif params[:initial_date].present?
        date = params[:initial_date]

        @event_research[:initial_date] = date
        result_page_data_func(ClientEventResearch, @event_research).nil? ? (redirect_to home_detailed_events_list_path) : result_page_data_func(ClientEventResearch, @event_research)
      else
        redirect_to home_date_select_path(@event_research)
      end
    else
      acronym = params[:party_acronym]
      id = params[:party_id]

      @parties_research = { id: id, acronym: acronym }

      # if @date_selector.include?(acronym)
      result_page_data_func(ClientPartiesResearch, @parties_research).nil? ? (redirect_to home_parties_list_path) : result_page_data_func(ClientPartiesResearch, @parties_research)
      # elsif params[:initial_date].present?
      #   date = params[:initial_date]

      #   @parties_research[:initial_date] = date
      #   result_page_data_func(ClientPartyResearch, @parties_research).nil? ? (redirect_to home_parties_list_path) : result_page_data_func(ClientPartyResearch, @parties_research)
      # else
      #   redirect_to home_date_select_path(@parties_research)
      # end
    end
  end
end
