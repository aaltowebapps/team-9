module TasksHelper
  def human_date(seconds)
    return nil unless seconds
    if seconds < 15
      "#{seconds.round} seconds"
    else
      distance_of_time_in_words(seconds, 0, true)
    end
  end
end
