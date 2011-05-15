class Participant < ActiveRecord::Base
  has_many :answers
  serialize :c_money, Array

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

  # Sets the current page to that of the page the participant
  # just submitted. Checks to prevent skipping ahead and to
  # ensure a valid page.
  def update_progress(page)
    unless page.nil?
      p = page.to_i
      if p > 0 && p <= self.page
        self.page = p
        self.save
      end
    end
  end

  # Increment the current page, and save.
  # If the end is reached, automatically sets completed to true.
  def next_page!
    self.page += 1
    if self.page > Question.count(:page, :distinct => true)
      self.completed = true
    end
    self.save
  end
end
