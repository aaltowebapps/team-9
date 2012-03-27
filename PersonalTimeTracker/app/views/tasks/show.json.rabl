object @task

attributes :id, :title, :average_time, :total_time, :latest_time, :run_count

node(:running) {|x| x.running?}