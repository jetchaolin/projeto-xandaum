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
  end
  def index
    @deputies_list = Deputies.all["dados"]
  end
  def detailed_events_list
    @events_list = Votes.all["dados"]
  end
  def show
    @result_page_data
  end
  def date_select
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
  end

  private

  def result
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
    def result_page_data_func(deputy)
      @result_page_data = ClientDeputiesResearch.search(deputy)
    end

    if @date_selector.include?(research)
      result_page_data_func(@deputies_research).nil? ? (redirect_to home_index_path) : result_page_data_func(@deputies_research)
    elsif params[:initial_date].present?
      date = params[:initial_date]

      @deputies_research[:initial_date] = date
      result_page_data_func(@deputies_research).nil? ? (redirect_to home_index_path) : result_page_data_func(@deputies_research)
    else
      redirect_to home_date_select_path(@deputies_research)
    end
  end
end
