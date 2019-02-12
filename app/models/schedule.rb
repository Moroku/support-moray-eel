class Schedule
  attr_accessor :name, :from_date, :to_date
  def initialize(name, from_date, to_date)
    @name = name
    @from_date = from_date
    @to_date = to_date
  end
end