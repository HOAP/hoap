module ReportHelper
  @@audit_ranges = [(0..7), (8..14), (15..19), (20..40)]

  def audit_class(score, level)
    if @@audit_ranges[level].include?(score)
      "audit_level a#{level}"
    else
      "audit_other"
    end
  end

  def ldq_suggestion(score)
    case score
    when 0
      "&hellip;you have control over your drinking and there is no reason for concern about the possibility of alcohol dependence, though this does not mean that alcohol is not adversely affecting some areas of your life."
    when (1..5)
      "&hellip;you are showing some signs of loss of control of your drinking. It is worth thinking seriously about whether your drinking is causing you or others problems. Is your drinking really OK - do the costs outweigh the benefits?"
    when (5..9)
      "&hellip;there is evidence of impaired control over your drinking and you may even have alcohol dependence. It is worth thinking seriously about whether your drinking is causing problems, being clear about what they are, and doing something about them."
    when (10..19)
      "&hellip;you have significantly impaired control over your drinking and may well have some degree of alcohol dependence. It is likely that alcohol is causing problems and that you would benefit from changing your drinking. You will probably find it easier to do this by getting help."
    else
      "&hellip;alcohol will almost certainly be causing you problems with a score above 19. You have significantly impaired control over your drinking and are likely to be dependent on alcohol to an extent that may well be difficult to change without help. Do something about it."
    end
  end

  def get_speedo(bac)
    if (bac < 0.02)
      ""
    elsif (bac < 0.05)
      "speedometer1.png"
    elsif (bac < 0.10)
      "speedometer2.png"
    elsif (bac < 0.15)
      "speedometer3.png"
    else
      "speedometer4.png"
    end
  end

  def get_speedo_alt(bac)
    if (bac < 0.02)
      ""
    elsif (bac <= 0.04)
      "At a blood alcohol level between 0.02-0.04 you are 1.4 times more likely to be killed in a single vehicle accident."
    elsif (bac <= 0.09)
      "At a blood alcohol level between 0.05-0.09 you are 11 times more likely to be killed in a single vehicle accident."
    elsif (bac <= 0.14)
      "At a blood alcohol level between 0.10-0.14 you are 48 times more likely to be killed in a single vehicle accident."
    else
      "At a blood alcohol level of 0.15 and above you are 380 times more likely to be killed in a single vehicle accident."
    end
  end

  def appointment_values
    {"Yes" => 1, "I'd like someone from Hunter New England Health to phone me to arrange another time because I cannot attend the clinic on a Friday afternoon" => 2, "Please ask me again 3 months from now" => 3, "No" => 4}
  end
end
