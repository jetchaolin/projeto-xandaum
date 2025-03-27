class Camara::V2::DeputySpeechAdapter
  def self.call(array, deputy_id)
    filtered_data = array
    if filtered_data != nil
      filtered_data.each do |item|
        # Find or initialize the speech record by a unique identifier (e.g., start_time or a combination of fields)
        Deputy.find_by(external_id: deputy_id)
        .deputy_speeches.find_or_initialize_by(start_time: item["dataHoraInicio"])
        .update({
          start_time: item["dataHoraInicio"], # Start time of the speech (e.g., "2025-03-12T18:12")
          end_time: item["dataHoraFim"], # End time of the speech (e.g., nil)
          event_uri: item["uriEvento"], # URI of the event (e.g., "")
          speech_type: item["tipoDiscurso"], # Type of speech (e.g., "DISCUSSÃO" or "BREVES COMUNICAÇÕES")
          text_url: item["urlTexto"], # URL of the speech text (e.g., "https://imagem.camara.gov.br/dc_20b.asp?...")
          audio_url: item["urlAudio"], # URL of the speech audio (e.g., nil)
          video_url: item["urlVideo"], # URL of the speech video (e.g., nil)
          keywords: item["keywords"], # Keywords related to the speech (e.g., nil)
          summary: item["sumario"], # Summary of the speech (e.g., "O Deputado Chico Alencar abordou a atual situação econômica...")
          transcription: item["transcricao"], # Full transcription of the speech (e.g., "O SR. CHICO ALENCAR (Bloco/PSOL - RJ. Sem revisão do orador.) - Eu vou cumprir o Regimento...")
          event_phase: {
            titulo: item.dig("faseEvento", "titulo"), # Title of the event phase (e.g., "Ordem do Dia")
            dataHoraInicio: item.dig("faseEvento", "dataHoraInicio"), # Start time of the event phase (e.g., nil)
            dataHoraFim: item.dig("faseEvento", "dataHoraFim") # End time of the event phase (e.g., nil)
          }
        }.compact_blank) # Remove blank values to avoid overwriting with nil
      end
    end
  end
end
