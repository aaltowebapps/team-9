class Task < ActiveRecord::Base
  has_many :runs, :dependent => :destroy

  def stop
    return nil unless running?
    running.complete!
  end

  def start
    Run.create(:task_id => id)
  end

  def running?
    running.present?
  end

  def running
    runs.reject(&:complete?).first
  end

  def run_count
    completed_runs.count
  end

  def completed_runs
    runs.select(&:complete?)
  end

  def total_time
    completed_runs.reduce(0) do |sum, value|
      sum + value.run_time
    end
  end

  def average_time
    total_time / completed_runs.count if completed_runs.count > 0
  end

  def latest_time
    runs.last.try(:run_time) unless running?
  end
end
