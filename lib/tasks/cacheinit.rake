require 'csv'

namespace :db do
  task :cacheinit => [:environment] do
    Participant.export_csv
  end
end
