class Answer < ActiveRecord::Base
  belongs_to :answer
  belongs_to :question

  def self.make_all(participant)
    questions = Question.all(:select => [:id, :page], :order => "id ASC")
    questions.each do |question|
      self.create(:participant_id => participant.id, :question_id => question.id, :page => question.page)
    end
  end

  def self.find_for(participant)
    self.where(:participant_id => participant.id, :page => participant.page).order("id ASC")
  end
end
