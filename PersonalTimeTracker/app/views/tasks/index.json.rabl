collection @tasks

attributes :id, :title, :run_count

node(:average_time) {|x| human_date(x.average_time) }
node(:total_time) {|x| human_date(x.total_time) }
node(:latest_time) {|x| human_date(x.latest_time) }

node(:running) {|x| x.running?}