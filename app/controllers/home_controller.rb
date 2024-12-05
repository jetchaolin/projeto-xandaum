class HomeController < ApplicationController
  def main
  end
  def index
    @deputies_list = Deputies.all["dados"]
  end
  def events
    @events_list = Votes.all["dados"]
  end
end
