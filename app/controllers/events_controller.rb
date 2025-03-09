class EventsController < ApplicationController
  before_action :result, only: %i[ show ]
  SUBJECT = "eventos".freeze
  CACHE_KEY = "events_all".freeze
  EXPIRING_TIME = 5.days
  DROP_LIST = [
    "eventos",
    "deputados",
    "orgaos",
    "pauta",
    "votacoes",
    "situacoesEvento",
    "tiposEvento",
    "codSituacaoEvento",
    "codTipoEvento"
  ].freeze
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
      @events_list = if Service::FetchList.by_date(SUBJECT, CACHE_KEY, EXPIRING_TIME, @initial_date, @final_date)["dados"].nil?
        # TODO: Notice - "Não foi possível encontrar"
        Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME)["dados"]
      else
        Service::FetchList.by_date(SUBJECT, CACHE_KEY, EXPIRING_TIME, @initial_date, @final_date)["dados"]
      end
    else
      @events_list = Service::FetchList.call(SUBJECT, CACHE_KEY, EXPIRING_TIME)["dados"]
    end
  end
  def show
    @result_page_data
  end

  def edit
    @event_option_subject = DROP_LIST
    @event_selected_id = params[:event_id]
    @event_selected_option = params[:options]
  end

  private

  def result
    @date_selector = DROP_LIST
    event_id = params[:event_id]
    options = params[:options]

    @event_research = { id: event_id, options: options }

    research_filter_func(ClientEventsResearch, @event_research)
  end
end
