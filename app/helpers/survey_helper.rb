module SurveyHelper
  @@audit_ranges = [(0..7), (8..14), (15..19), (20..40)]

  def audit_class(score, level)
    if @@audit_ranges[level].include?(score)
      "audit_level"
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
end
