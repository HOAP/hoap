namespace :user do
  task :make => :environment do
    @participant = Participant.make
    puts "http://hoap.heroku.com/s/#{@participant.key}"
  end
end
