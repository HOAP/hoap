# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

pages = [
  [
    {:page => 2, :text => "What is your gender?", :atype => "R", :values => %w{Male Female}},
    {:page => 2, :text => "What is your age?", :atype => "S", :values => %w{18-19 20-24 25-29 30-34 35-39 40-44 45-49 50-54 55-59 60-64 65-69 70-74 75-79 80-84 85+}},
    {:page => 2, :text => "What is your postcode?", :atype => "T"}
  ],
  [
    {:page => 3, :text => "Have you had a drink containing alcohol in the <strong>LAST 12 MONTHS</strong>?", :atype => "R", :values => %w{Yes No}}
  ],
  [
    {:page => 4, :text => "How often do you have a drink containing alcohol?", :atype => "S", :values => {"Never or almost never" => "0", "Less than once a month" => "1", "Once a month" => "1", "Once every two weeks" => "2", "Once a week" => "2", "Two or three times a week" => "3", "Four or five times a week" => "4", "Six or seven times a week" => "4"}},
    {:page => 4, :text => "How many Standard Drinks containing alcohol do you have on a typical day when you are drinking? (Please refer to the Standard Drinks guide on the left)", :atype => "S", :values => {"1" => "0", "2" => "0", "3" => "1", "4" => "1", "5" => "2", "6" => "2", "7" => "3", "8" => "3", "9" => "3", "10" => "4", "11" => "4", "12" => "4", "13" => "4", "14" => "4", "15" => "4", "16" => "4", "17" => "4", "18" => "4", "19" => "4", "20" => "4", "21" => "4", "22" => "4", "23" => "4", "24" => "4", "25-29" => "4", "30-34" => "4", "35-39" => "4", "40-49" => "4", "50 or more" => "4"}},
    {:page => 4, :text => "How often do you have 6 or more Standard Drinks on one occasion?", :atype => "S", :values => {"Never" => "0", "Once or twice a year" => "1", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "How often during the last year have you found that you were not able to stop drinking once you had started?", :atype => "S", :values => {"Never" => "0", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "How often during the last year have you failed to do what was normally expected of you because of drinking?", :atype => "S", :values => {"Never" => "0", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "How often during the last year have you needed a first drink in the morning to get yourself going after a heavy drinking session?", :atype => "S", :values => {"Never" => "0", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "How often during the last year have you had a feeling of guilt or remorse after drinking?", :atype => "S", :values => {"Never" => "0", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "How often during the last year have you been unable to remember what happened the night before because of your drinking?", :atype => "S", :values => {"Never" => "0", "Less than monthly" => "1", "Monthly" => "2", "Weekly" => "3", "Daily or almost daily" => "4"}},
    {:page => 4, :text => "Have you or someone else been injured because of your drinking?", :atype => "S", :values => {"No" => "0", "Yes, but not in the last year" => "2", "Yes, during the last year" => "4"}},
    {:page => 4, :text => "Has a relative, friend, doctor or other health worker been concerned about your drinking or suggested you cut down?", :atype => "S", :values => {"No" => "0", "Yes, but not in the last year" => "2", "Yes, during the last year" => "4"}}
  ],
  [
    {:page => 5, :text => "Have you had a drink containing alcohol in the <strong>LAST 4 WEEKS</strong>?", :atype => "R", :values => %w{Yes No}}
  ],
  [
    {:page => 6, :text => "In the LAST 4 WEEKS what is the largest number of Standard Drinks you have consumed on a single occasion?", :atype => "S", :values => {"1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "10" => "10", "11" => "11", "12" => "12", "13" => "13", "14" => "14", "15" => "15", "16" => "16", "17" => "17", "18" => "18", "19" => "19", "20" => "20", "21" => "21", "22" => "22", "23" => "23", "24" => "24", "25-29" => "27", "30-34" => "32", "35-39" => "37", "40-44" => "42", "45-49" => "47", "50 or more" => "50"}},
    {:page => 6, :text => "Over how many hours did you drink this amount (to the nearest hour)?", :atype => "S", :values => {"1" => "1", "2" => "2", "3" => "3", "4" => "4", "5" => "5", "6" => "6", "7" => "7", "8" => "8", "9" => "9", "10" => "10", "11" => "11", "12" => "12", "13" => "13", "14" => "14", "15" => "15", "16" => "16", "17" => "17", "18" => "18", "19" => "19", "20" => "20", "21" => "21", "22" => "22", "23" => "23", "24" => "24"}},
    {:page => 6, :text => "Height", :atype => "T"},
    {:page => 6, :text => "Weight", :atype => "T"}
  ],
  [
    {:page => 7, :text => "Do you find your self thinking about when you will next be able to have another drink?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Is drinking more important than anything else you might do during the day?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you feel your need for drink is too strong to control?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you plan your days around getting drink and drinking?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you drink in a particular way in order to increase the effect it gives you?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you drink morning, afternoon and evening?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you feel you have to carry on drinking once you have started?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Is getting the effect you want more important than the particular drink you use?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you want to drink more when the effect starts to wear off?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}},
    {:page => 7, :text => "Do you find it difficult to cope with life without drink?", :atype => "S", :values => {"Never" => "0", "Sometimes" => "1", "Often" => "2", "Nearly always" => "3"}}
  ],
  [
    {:page => 8, :text => "Have you had any fractures or dislocations to your bones or joints?", :atype => "S", :values => {"Yes" => "1", "No" => "0", "Prefer not to answer" => "9"}},
    {:page => 8, :text => "Have you been injured in a road traffic accident?", :atype => "S", :values => {"Yes" => "1", "No" => "0", "Prefer not to answer" => "9"}},
    {:page => 8, :text => "Have you injured your head?", :atype => "S", :values => {"Yes" => "1", "No" => "0", "Prefer not to answer" => "9"}},
    {:page => 8, :text => "Have you been injured in an assault or fight (excluding injuries during sports)?", :atype => "S", :values => {"Yes" => "1", "No" => "0", "Prefer not to answer" => "9"}},
    {:page => 8, :text => "Have you been injured after drinking?", :atype => "S", :values => {"Yes" => "1", "No" => "0", "Prefer not to answer" => "9"}}
  ]
]

pages.each do |page|
  page.each do |question|
    Question.create(question)
  end
end
