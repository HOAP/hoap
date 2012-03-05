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
    if self.page > Question.count(:page, :distinct => true)
      self.completed = true
    end
    self.page += 1
    # Skip pages when answering no to Question on page 3 or 5
    if self.page == 4
      answer = Answer.where(:participant_id => self.id, :page => 3).select(:value).first
      if answer.value =~ /no/i
        self.page = 8
      end
    elsif self.page == 6
      answer = Answer.where(:participant_id => self.id, :page => 5).select(:value).first
      if answer.value =~ /no/i
        self.page = 8
      end
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
      self.c_money = [dpy * 1.5, dpy * 6.0]
      self.save
    end
    self.c_money
  end

  def bac
    if self.c_bac.nil?
      # Get the values of the Answers needed for the calculation
      reqd_answers = Answer.where(:participant_id => self.id, :page => 6).pluck(:value)
      reqd_answers += Answer.where(:participant_id => self.id, :page => 2).pluck(:value)
      # Number of Standard Drinks
      sd = reqd_answers[0].to_i
      # Body Water constant
      bw = 0.58 # Males
      if reqd_answers[4] == "Female"
        bw = 0.49
      end
      # Weight
      wt = reqd_answers[3].to_f
      # Metabolism Rate
      if self.audit <= 7
        mr = 0.017
      else
        mr = 0.02
      end
      # Drinking Period
      dp = reqd_answers[1].to_i
      self.c_bac = ((0.806 * sd) / ((bw * wt) - (mr * dp))).round(2)
      self.save
    end
    self.c_bac.to_f
  end
end
