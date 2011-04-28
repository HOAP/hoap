class Question < ActiveRecord::Base
  has_many :answers
  serialize :values

  def self.find_for(participant)
    self.where(:page => participant.page).order("id ASC")
  end
end
