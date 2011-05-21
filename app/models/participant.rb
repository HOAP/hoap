class Participant < ActiveRecord::Base
  has_many :answers
  serialize :c_money, Array

  @@audit_values = {
    5 => {"Never or almost never" => 0, "Less than once a month" => 1, "Once a month" => 1, "Once every two weeks" => 2, "Once a week" => 2, "Two or three times a week" => 3, "Four or five times a week" => 4, "Six or seven times a week" => 4},
    6 => {"1" => 0, "2" => 0, "3" => 1, "4" => 1, "5" => 2, "6" => 2, "7" => 3, "8" => 3, "9" => 3, "10" => 4, "11" => 4, "12" => 4, "13" => 4, "14" => 4, "15" => 4, "16" => 4, "17" => 4, "18" => 4, "19" => 4, "20" => 4, "21" => 4, "22" => 4, "23" => 4, "24" => 4, "25-29" => 4, "30-34" => 4, "35-39" => 4, "40-49" => 4, "50 or more" => 4},
    7 => {"Never" => 0, "Once or twice a year" => 1, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    8 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    9 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    10 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    11 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    12 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    13 => {"No" => 0, "Yes, but not in the last year" => 2, "Yes, during the last year" => 4},
    14 => {"No" => 0, "Yes, but not in the last year" => 2, "Yes, during the last year" => 4}
  }

  def audit_score(question, answer)
    @@audit_values[question][answer]
  end

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

  # The AUDIT score (page 4)
  def audit
    if self.c_audit.nil?
      answers = Answer.where(:participant_id => self.id, :page => 4).order("id ASC")
      self.c_audit = answers.reduce(0) do |sum, a|
        sum + audit_score(a.question_id, a.value)
      end
      self.save
    end
    self.c_audit
  end

  # The Leeds Dependence Questionnaire score (page 7)
  def ldq
    if self.c_ldq.nil?
      answers = Answer.where(:participant_id => self.id, :page => 7).order("id ASC")
      self.c_ldq = answers.reduce(0) do |sum, a|
        sum + a.value.to_i
      end
      self.save
    end
    self.c_ldq
  end

  def typical_drinks
    Answer.where(:participant_id => self.id, :question_id => 6).select(:value).first.value
  end

  def dpw
    if self.c_dpw.nil?
      drinks = typical_drinks.to_i
      frequency = Answer.where(:participant_id => self.id, :question_id => 5).select(:value).first.value
      case frequency
      when /^Never/
        mult = 0
      when /^(Less)|(Once a month)/
        mult = 0.25
      when /two weeks$/
        mult = 0.5
      when /Once a week/
        mult = 1
      when /^Two/
        mult = 2.5
      when /^Four/
        mult = 4.5
      when /^Six/
        mult = 6.5
      end
      self.c_dpw = drinks * mult
    end
    self.c_dpw
  end

  def money
    if self.c_money.nil?
      dpy = self.dpw * 52
      # TODO: get correct minimum and maximum dollar value per drink.
      self.c_money = [dpy * 1.5, dpy * 6.5]
      self.save
    end
    self.c_money
  end

  def bac
    if self.c_bac.nil?
      # TODO: find correct method of calculating BAC.
      self.c_bac = 0.13
    end
    self.c_bac
  end
end
