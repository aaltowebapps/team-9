class Run < ActiveRecord::Base
  belongs_to :task

  def complete?
    completed_at?
  end

  def complete!
    touch(:completed_at)
  end

  def run_time
    completed_at - created_at if complete?
  end
end
