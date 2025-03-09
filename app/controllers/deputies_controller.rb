class DeputiesController < ApplicationController
  before_action :result, only: %i[ show ]
  SUBJECT = "deputados".freeze
  CACHE_KEY = "deputies_all".freeze
  EXPIRING_TIME = 5.days
  DROP_LIST = [
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
  ].freeze
  def index
    @deputies_research_subject = DROP_LIST
    @deputy_selected_id = params[:deputy_id]
    @deputy_selected_name = params[:deputy_name]
    @deputies_list = Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME)["dados"]
  end
  def show
    @result_page_data
  end
  def edit
    @deputies_research_subject = DROP_LIST
    @deputy_selected_id = params[:id]
    @deputy_selected_name = params[:name]
    @deputy_selected_research = params[:options]
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
    deputy_id = params[:id]
    deputy_name = params[:name]
    research = (params[:research] || params[:options])

    @deputies_research = { name: deputy_name, id: deputy_id, options: research }

    research_filter_func(ClientDeputiesResearch, @deputies_research)
  end
end
