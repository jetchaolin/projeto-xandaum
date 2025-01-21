class DeputiesController < ApplicationController
  before_action :result, only: %i[ show ]
  def index
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
    @deputies_list = Deputies.all["dados"]
  end
  def show
    @result_page_data
  end
  def edit
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
      redirect_to edit_deputy_path(option)
    end
  end
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
    research = (params[:research] || params[:options])
    id = params[:id]

    @deputies_research = { name: name, id: id, options: research }

    research_filter_func(ClientDeputiesResearch, @deputies_research)
  end
end
