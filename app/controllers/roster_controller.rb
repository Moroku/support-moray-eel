class RosterController < ApplicationController
  before_action :set_motd
  def index
    names = ["Bennie", "Soumya", "Evan", "Nischal"]
    make_roster(names)

    @date_format = "%d - %B"

    respond_to do |format|
      format.json { render }
      format.html { render }
    end
  end

  private
    def make_roster(names)
      @roster = []
      len = names.length
      today = Date.current
      if today.end_of_week == today then
        today = today.tomorrow.tomorrow
      end
      names.each do |n|
        week_num = today.strftime("%U").to_i
        x = week_num % len
        start_week = today.beginning_of_week
        end_week = today.end_of_week
        @roster << Schedule.new(names[x], start_week, end_week)
        today = today.next_week(:tuesday)
      end
    end

    def set_motd
      @motd = "Have a great day!"
    end
end
