class ClientDeputiesResearch
  def self.search(deputies_research)
    @user_research = deputies_research
    @get_deputies_list_from_the_api = Rails.cache.read("deputies_all") ? Rails.cache.fetch("deputies_all") : Deputies.all
    @filtered_deputies_ids_and_names = @get_deputies_list_from_the_api["dados"].map do |deputy|
      { id: deputy["id"], name: deputy["nome"] }
    end
    @found_deputy = @filtered_deputies_ids_and_names.find { |item| item[:name] == @user_research[:name] }

    if @found_deputy.nil?
      return { "dados": "Deputado não encontrado" }
    end

    if @user_research[:research] == "deputado"
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}"
    elsif @user_research[:research] == ("lideres" || "mesa")
      @url = "https://dadosabertos.camara.leg.br/api/v2/legislaturas/#{@found_deputy[:id]}/#{@user_research[:research]}"
    elsif @user_research[:initial_date].present?
      @initial_date = "?dataInicio=#{@user_research[:initial_date]}&ordenarPor=dataHoraInicio&ordem=DESC"
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}/#{@user_research[:research]}#{@initial_date}"
    else
      @url = "https://dadosabertos.camara.leg.br/api/v2/deputados/#{@found_deputy[:id]}/#{@user_research[:research]}"
    end

    headers = {
      "Accept" => "application/json"
    }
    response = Faraday.get(@url, nil, headers)
    JSON.parse(response.body)
  end
end
