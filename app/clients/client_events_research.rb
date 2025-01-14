class ClientEventsResearch
  def self.search(events_research)
    @events_research = events_research
    @get_events_list_from_the_api = Rails.cache.read("filtered_events") ? Rails.cache.read("filtered_events") : Rails.cache.read("events_all") ? Rails.cache.fetch("events_all") : Events.all
    @filtered_events_ids_and_options = @get_events_list_from_the_api["dados"].map do |event|
      { id: (event["id"]).to_s, options: @events_research[:options] }
    end
    @found_event = @filtered_events_ids_and_options.find { |item| item[:id] == @events_research[:id] }

    if @found_event.nil?
      return { "dados": "Evento não encontrado" }
    end

    if @events_research[:options] == "eventos"
      @url = "https://dadosabertos.camara.leg.br/api/v2/eventos/#{@found_event[:id]}"
    elsif @events_research[:options] == ("situacoesEvento" || "tiposEvento")
      @url = "https://dadosabertos.camara.leg.br/api/v2/referencias/#{@events_research[:options]}"
    elsif @events_research[:options] == ("codSituacaoEvento" || "codTipoEvento")
      @url = "https://dadosabertos.camara.leg.br/api/v2/referencias/eventos/#{@events_research[:options]}"
    elsif @events_research[:initial_date].present?
      @initial_date = "?dataInicio=#{@events_research[:initial_date]}&ordenarPor=dataHoraInicio&ordem=DESC"
      @url = "https://dadosabertos.camara.leg.br/api/v2/eventos/#{@found_event[:id]}/#{@events_research[:options]}#{@initial_date}"
    else
      @url = "https://dadosabertos.camara.leg.br/api/v2/eventos/#{@found_event[:id]}/#{@events_research[:options]}"
    end
    headers = {
      "Accept" => "application/json"
    }

    response = Faraday.get(@url, nil, headers)
    JSON.parse(response.body)
  end
end
