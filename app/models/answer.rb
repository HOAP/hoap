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

  # Save all Answers for a given submitted page
  def self.save_all(params)
    answers = []
    error_count = 0
    unless params == nil
      params.each do |id, line|
        ans = Answer.find(id)
        ans.update_attributes(line)
        error_count += ans.errors.count
        answers << ans
      end
    end
    answers.sort_by! { |ans| ans.id }
    return answers, error_count
  end

  def self.values(participant_id)
    return self.where(:participant_id => participant_id).order("id ASC").pluck(:value)
  end

  def self.from_a(participant_id, ary)
    values = ary[18..(ary.length - 1)]
    questions = Question.all(:select => [:id, :page], :order => "id ASC")
    questions.each do |question|
      Answer.create(:participant_id => participant_id, :question_id => question.id, :page => question.page, :value => values.shift)
    end
  end
end
