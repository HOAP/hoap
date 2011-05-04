class Participant < ActiveRecord::Base
  has_many :answers

  def self.make
    begin
      key = Digest::SHA1.hexdigest("#{rand} - #{Time.now.to_f}")[0..11]
      participant = self.create(:key => key)
    rescue
      retry
    end
    Answer.make_all(participant)
    return participant
  end
end
