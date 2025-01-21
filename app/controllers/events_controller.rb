class EventsController < ApplicationController
  before_action :result, only: %i[ show ]
  def index
    @event_option_subject = [
      "eventos",
      "deputados",
      "orgaos",
      "pauta",
      "votacoes",
      "situacoesEvento"
      # "tiposEvento"
    ]
    @event_selected_id = params[:event_id]

    if (params[:initial_date] || params[:final_date]).present?
      @initial_date = params[:initial_date] || nil
      @final_date = params[:final_date] || nil
      @events_list = Events.by_date(@initial_date, @final_date)["dados"] ? Events.by_date(@initial_date, @final_date)["dados"] : Events.all["dados"]
    else
      @events_list = Events.all["dados"]
    end
  end
  def show
    @result_page_data
  end
  def edit
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
      redirect_to edit_event_path(option)
    end
  end
  def result
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

      research_filter_func(ClientEventsResearch, @event_research)
  end
end
