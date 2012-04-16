namespace :user do
  task :make, [:count] => [:environment] do |t, args|
    count = (args[:count] || 1).to_i
    count.times do
      @participant = Participant.make
      puts "http://hoap.herokuapp.com/s/#{@participant.key}"
    end
  end
end
