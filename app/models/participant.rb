class Participant < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  has_many :answers
  serialize :c_money, Array

  @@control_pct = 50

  @@audit_values = {
    6 => {"Never or almost never" => 0, "Less than once a month" => 1, "Once a month" => 1, "Once every two weeks" => 2, "Once a week" => 2, "Two or three times a week" => 3, "Four or five times a week" => 4, "Six or seven times a week" => 4},
    7 => {"1" => 0, "2" => 0, "3" => 1, "4" => 1, "5" => 2, "6" => 2, "7" => 3, "8" => 3, "9" => 3, "10" => 4, "11" => 4, "12" => 4, "13" => 4, "14" => 4, "15" => 4, "16" => 4, "17" => 4, "18" => 4, "19" => 4, "20" => 4, "21" => 4, "22" => 4, "23" => 4, "24" => 4, "25-29" => 4, "30-34" => 4, "35-39" => 4, "40-49" => 4, "50 or more" => 4},
    8 => {"Never" => 0, "Once or twice a year" => 1, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    9 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    10 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    11 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    12 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    13 => {"Never" => 0, "Less than monthly" => 1, "Monthly" => 2, "Weekly" => 3, "Daily or almost daily" => 4},
    14 => {"No" => 0, "Yes, but not in the last year" => 2, "Yes, during the last year" => 4},
    15 => {"No" => 0, "Yes, but not in the last year" => 2, "Yes, during the last year" => 4}
  }

  @@avg_dpo = {
    "Male" => {"18-19" => 5.5, "20-24" => 3.5, "25-29" => 3.5, "30-34" => 3.5, "35-39" => 3.5, "40-44" => 3.5, "45-49" => 3.5, "50-54" => 3.5, "55-59" => 1.5, "60-64" => 1.5, "65-69" => 1.5, "70-74" => 1.5, "75-79" => 1.5, "80-84" => 1.5, "85+" => 1.5},
    "Female" => {"18-19" => 3.5, "20-24" => 3.5, "25-29" => 1.5, "30-34" => 1.5, "35-39" => 1.5, "40-44" => 1.5, "45-49" => 1.5, "50-54" => 1.5, "55-59" => 1.5, "60-64" => 1.5, "65-69" => 1.5, "70-74" => 1.5, "75-79" => 1.5, "80-84" => 1.5, "85+" => 1.5}
  }

  @@avg_dpw = {
    "Male" => {"18-19" => 5.25, "20-24" => 5.25, "25-29" => 5.25, "30-34" => 5.25, "35-39" => 5.25, "40-44" => 5.25, "45-49" => 5.25, "50-54" => 5.25, "55-59" => 5.25, "60-64" => 5.25, "65-69" => 5.25, "70-74" => 5.25, "75-79" => 5.25, "80-84" => 2.25, "85+" => 2.25},
    "Female" => {"18-19" => 2.25, "20-24" => 2.25, "25-29" => 1.75, "30-34" => 1.75, "35-39" => 1.75, "40-44" => 2.25, "45-49" => 2.25, "50-54" => 0.875, "55-59" => 0.75, "60-64" => 0.875, "65-69" => 0.375, "70-74" => 0.375, "75-79" => 0.375, "80-84" => 0, "85+" => 0}
  }

  @@themes = {
    :two => {:colors=>["#339933", "red"], :marker_color=>"black", :font_color=>"black", :background_colors=>["#d1edf5", "white"]},
    :three => {:colors=>["#339933", "#336699", "red"], :marker_color=>"black", :font_color=>"black", :background_colors=>["#d1edf5", "white"]}
  }

  @@public_key = nil
  @@private_key = nil

  def audit_score(question, answer)
    @@audit_values[question][answer]
  end

  def self.make(code)
    begin
      key = Digest::SHA1.hexdigest("#{rand} - #{Time.now.to_f}")[0..11]
      participant = self.create(:key => key, :code => code)
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
    # Exit as appropriate (i.e. Control, Ineleigible, Completed)
    if self.page == 3 || self.page == 4 || self.page == 7
      answer = Answer.where(:participant_id => self.id, :page => self.page).pluck(:value)
      if self.page == 3 && answer[0] =~ /no/i
        # Ineligible if they have not consumed alcohol in last year.
        self.exit_code = 1
        self.completed = true
      elsif self.page == 4 && answer[0] =~ /yes/i
        # Ineligible if they are currently receiving treatment for alcohol use.
        self.exit_code = 2
        self.completed = true
      elsif self.page == 7 && answer[0] =~ /no/i
        # Skip LDQ if not drunk any alcohol in last 4 weeks.
        self.page += 2
      end
    elsif self.page == 5
      # Check AUDIT-C
      if self.audit_c < 5
        # Ineligible if they have sensible drinking habits.
        self.exit_code = 3
        self.completed = true
      else
        # Stratify into control/subject
        if SecureRandom.random_number(100) < @@control_pct
          self.exit_code = 4
          self.completed = true
        end
      end
    end
    if !self.completed
      self.page += 1
      if self.page > Question.maximum(:page)
        self.completed = true
      end
    end
    self.save
  end

  # Return the current URL the participant should be directed to.
  def current_path
    if self.completed && self.exit_code == 0
      return report_path(self.key)
    else
      return page_path(self.key)
    end
  end

  # The AUDIT-C score (page 5) - a reduced AUDIT to check eligibility.
  def audit_c
    if self.c_audit_c.nil?
      answers = Answer.where(:participant_id => self.id, :page => 5).order("id ASC")
      self.c_audit_c = answers.reduce(0) do |sum, a|
        sum + audit_score(a.question_id, a.value)
      end
      self.save
    end
    return self.c_audit_c
  end

  # The AUDIT score (page 5 & 6)
  def audit
    if self.c_audit.nil?
      answers = Answer.where(:participant_id => self.id, :page => [5, 6]).order("id ASC")
      self.c_audit = answers.reduce(0) do |sum, a|
        sum + audit_score(a.question_id, a.value)
      end
      self.save
    end
    self.c_audit
  end

  # The Leeds Dependence Questionnaire score (page 9)
  def ldq
    if self.c_ldq.nil?
      answers = Answer.where(:participant_id => self.id, :page => 9).order("id ASC")
      self.c_ldq = answers.reduce(0) do |sum, a|
        sum + a.value.to_i
      end
      self.save
    end
    self.c_ldq
  end

  def typical_drinks
    values = Answer.where(:participant_id => self.id, :page => 5).order("id ASC").pluck(:value)
    return values[1]
  end

  def dpw
    if self.c_dpw.nil?
      values = Answer.where(:participant_id => self.id, :page => 5).order("id ASC").pluck(:value)
      case values[0]
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
      self.c_dpw = values[1].to_i * mult
    end
    self.c_dpw
  end

  def money
    if self.c_money.empty?
      dpy = self.dpw * 52
      self.c_money = [dpy * 1.5, dpy * 6.0]
      self.save
    end
    self.c_money
  end

  def bac
    if self.c_bac.nil?
      # Get the values of the Answers needed for the calculation
      reqd_answers = Answer.where(:participant_id => self.id, :page => 8).order("id ASC").pluck(:value)
      reqd_answers += Answer.where(:participant_id => self.id, :page => 2).order("id ASC").pluck(:value)
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

  def display_dpo?
    a = Answer.where(:participant_id => self.id, :page => 5).order("id ASC").limit(2).pluck(:value)
    return a[1].to_i > 4
  end

  def display_dpw?
    return self.dpw > 14
  end

  def dpo_graph
    g = Gruff::Bar.new(400)
    if (self.show_peer_dpo?)
      g.theme = @@themes[:three]
    else
      g.theme = @@themes[:two]
    end
    g.bar_spacing = 0.6
    g.title = "Average Number of Standard Drinks"
    g.data("Australian Medical Guidelines", 4)
    if (self.show_peer_dpo?)
      a = Answer.where(:participant_id => self.id, :page => 2).order("id ASC").limit(2).pluck(:value)
      g.data(self.peergroup, @@avg_dpo[a[0]][a[1]])
    end
    a = Answer.where(:participant_id => self.id, :page => 5).order("id ASC").limit(2).pluck(:value)
    g.data("YOU", a[1].to_i)
    g.sort = false
    g.minimum_value = 0
    return g.to_blob
  end

  def dpw_graph
    g = Gruff::Bar.new(400)
    if (self.show_peer_dpw?)
      g.theme = @@themes[:three]
    else
      g.theme = @@themes[:two]
    end
    g.bar_spacing = 0.6
    g.title = "Standard Drinks Per Week"
    g.data("Australian Medical Guidelines", 14)
    if (self.show_peer_dpw?)
      a = Answer.where(:participant_id => self.id, :page => 2).order("id ASC").limit(2).pluck(:value)
      g.data(self.peergroup, @@avg_dpw[a[0]][a[1]])
    end
    g.data("YOU", self.dpw)
    g.sort = false
    g.minimum_value = 0
    return g.to_blob
  end

  def audit_only?
    a = Answer.where(:participant_id => self.id, :page => 7).pluck(:value)
    return a[0] == "No"
  end

  def peergroup
    if self[:peergroup].blank?
      a = Answer.where(:participant_id => self.id, :page => 2).order("id ASC").limit(2).pluck(:value)
      self[:peergroup] = "#{a[1]} year old "
      if a[0] =~ /female/i
        self[:peergroup] += "women"
      else
        self[:peergroup] += "men"
      end
      self[:peergroup] += " in Australia"
      self.save
    end
    return self[:peergroup]
  end

  def show_peer_dpo?
    if self.peer_dpo.nil?
      a = Answer.where(:participant_id => self.id, :page => 2).order("id ASC").limit(2).pluck(:value)
      a += Answer.where(:participant_id => self.id, :page => 5).order("id ASC").limit(2).pluck(:value)
      self.peer_dpo = a[3].to_i >= @@avg_dpo[a[0]][a[1]]
    end
    return self.peer_dpo
  end

  def show_peer_dpw?
    if self.peer_dpw.nil?
      a = Answer.where(:participant_id => self.id, :page => 2).order("id ASC").limit(2).pluck(:value)
      self.peer_dpw = self.dpw >= @@avg_dpw[a[0]][a[1]]
    end
    return self.peer_dpw
  end

  def email=(email)
    if @@public_key.nil?
      @@public_key = OpenSSL::PKey::RSA.new(File.read("config/public.pem"))
    end
    unless email.blank?
      self[:email] = @@public_key.public_encrypt(email)
    end
  end

  def email
    if self[:email].blank?
      return nil
    end
    if @@private_key.nil?
      if File.exists?("config/private.pem")
        @@private_key = OpenSSL::PKey::RSA.new(File.read("config/private.pem"))
      else
        return Base64.encode64(self[:email]).gsub(/\n/, "")
      end
    end
    return @@private_key.private_decrypt(self[:email])
  end

  def to_a
    results = [self.id, self.code, self.name, self.email, self.completed]
    results += [self.c_audit, self.c_bac, self.c_ldq]
    results += [self.report_time, self.facts_time, self.support_time, self.tips_time]
    results += Answer.values(self.id)
    return results
  end

  def increment_time(page, time)
    if page =~ /^report|facts|support|tips$/
      self[(page + "_time").to_sym] += time.to_i
      self.save
    end
    return self[(page + "_time").to_sym]
  end
end
