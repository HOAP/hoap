class Question < ActiveRecord::Base
  has_many :answers
  serialize :values
end
