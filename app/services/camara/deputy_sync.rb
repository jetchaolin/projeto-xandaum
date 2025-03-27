class Camara::DeputySync
  MAIN = "deputados".freeze
  CACHE_KEY = "deputies_all".freeze
  EXPIRING_TIME = 5.days

  def self.single(deputies_research)
    Rails.logger.debug "Syncing #{deputies_research}"
    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputyAdapter.call(deputy_found)

    self.single_expenses(deputies_research)
  end

  def self.single_expenses(deputies_research)
    deputies_research[:options] = "despesas"
    Rails.logger.debug "Syncing expenses #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputyExpenseAdapter.call(deputy_found, deputies_research[:id])

    self.single_speeches(deputies_research)
  end

  def self.single_speeches(deputies_research)
    deputies_research[:options] = "discursos"
    Rails.logger.debug "Syncing speeches #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputySpeechAdapter.call(deputy_found, deputies_research[:id])

    self.single_fronts(deputies_research)
  end

  def self.single_fronts(deputies_research)
    deputies_research[:options] = "frentes"
    Rails.logger.debug "Syncing fronts #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::FrontAdapter.call(deputy_found, deputies_research[:id])

    self.single_history(deputies_research)
  end

  def self.single_history(deputies_research)
    deputies_research[:options] = "historico"
    Rails.logger.debug "Syncing history #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputyHistoryAdapter.call(deputy_found, deputies_research[:id])

    self.single_external_mandates(deputies_research)
  end

  def self.single_external_mandates(deputies_research)
    deputies_research[:options] = "madatosExternos"
    Rails.logger.debug "Syncing external_mandates #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputyExternalMandatesAdapter.call(deputy_found, deputies_research[:id])

    self.single_professions(deputies_research)
  end

  def self.single_professions(deputies_research)
    deputies_research[:options] = "profissoes"
    Rails.logger.debug "Syncing professions #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::ProfessionAdapter.call(deputy_found, deputies_research[:id])

    self.single_ocupations(deputies_research)
  end

  def self.single_ocupations(deputies_research)
    deputies_research[:options] = "ocupacoes"
    Rails.logger.debug "Syncing ocupations #{deputies_research}"

    deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
    Camara::V2::DeputyOcupationAdapter.call(deputy_found, deputies_research[:id])
  end

  def self.all
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "deputado" }
      sleep(0.3)
      deputy_found = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputyAdapter.call(deputy_found)
    end
  end


  def self.expenses
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "despesas" }
      sleep(0.3)
      deputy_expenses = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputyExpenseAdapter.call(deputy_expenses, deputy["id"])
    end
  end

  def self.speeches
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "discursos", initial_date: "2021-01-01" }
      sleep(0.3)
      deputy_speech = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputySpeechAdapter.call(deputy_speech, deputy["id"])
    end
  end

  def self.fronts
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "frentes" }
      sleep(0.3)
      deputy_front = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::FrontAdapter.call(deputy_front, deputy["id"])
    end
  end

  def self.history
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      sleep(0.3)
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "historico" }
      deputy_history = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputyHistoryAdapter.call(deputy_history, deputy["id"])
    end
  end

  def self.external_mandates
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      sleep(0.3)
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "mandatosExternos" }
      deputy_external_mandates = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputyExternalMandatesAdapter.call(deputy_external_mandates, deputy["id"])
    end
  end

  def self.professions
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      sleep(0.3)
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "profissoes" }
      professions = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::ProfessionAdapter.call(professions, deputy["id"])
    end
  end

  def self.ocupations
    json_deputies = Service::FetchList.call(MAIN, CACHE_KEY, EXPIRING_TIME)
    deputies_list = json_deputies["dados"]
    deputies_list.map do |deputy|
      sleep(0.3)
      deputies_research = { id: deputy["id"], name: deputy["nome"], options: "ocupacoes" }
      deputy_ocupation = ClientDeputiesResearch.search(deputies_research)["dados"]
      Camara::V2::DeputyOcupationAdapter.call(deputy_ocupation, deputy["id"])
    end
  end
end
