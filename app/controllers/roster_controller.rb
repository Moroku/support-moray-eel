class RosterController < ApplicationController
  before_action :set_motd
  def index
    names = ["Bennie", "Soumya", "Evan", "Nischal", "Nam"]
    make_roster(names, params[:results])

    @date_format = "%d - %B"

    respond_to do |format|
      format.json { render }
      format.html { render }
    end
  end

  private
    def make_roster(names, results = nil)
      @roster = []
      len = names.length
      results ||= len
      results = results.to_i
      # Don't allow more than 2 years of data
      results = [results, 104].min
      results = [results, 1].max
      today = Date.current
      if today.end_of_week == today then
        today = today.tomorrow.tomorrow
      end
      (0...results).each do |n|
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
