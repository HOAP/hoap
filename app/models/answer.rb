class Answer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :question

  def self.find_for(participant)
    self.where(:participant_id => participant.id, :page => participant.page).order("id ASC")
  end
end
