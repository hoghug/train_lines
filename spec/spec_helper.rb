require 'rspec'
require 'pg'
require 'operator'
require 'rider'


DB = PG.connect({:dbname => 'train_stations_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM train_lines *;")
    DB.exec("DELETE FROM stations *;")
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM riders *;")
  end
end

# -a-b-c-d-e-f-g
#             \
#             f-v-w-x-y-z
#                   \
#                    x-m-l-n-o-p
#             line1b4connect.length = 5
#             puts "\s"
