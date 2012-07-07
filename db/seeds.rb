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
    {:page => 2, :text => "What is your postcode?", :atype => "S", :values => %w{2264 2265 2267 2278 2280 2281 2282 2283 2284 2285 2286 2287 2289 2290 2291 2292 2293 2294 2295 2296 2297 2298 2299 2300 2302 2303 2304 2305 2306 2307 2308 2309 2311 2312 2314 2315 2316 2317 2318 2319 2320 2321 2322 2323 2324 2325 2326 2327 2328 2329 2330 2331 2333 2334 2335 2336 2337 2338 2339 2340 2341 2342 2343 2344 2345 2346 2347 2350 2352 2353 2354 2355 2358 2359 2360 2361 2365 2369 2370 2371 2372 2379 2380 2381 2382 2388 2390 2397 2398 2399 2400 2401 2402 2403 2404 2405 2408 2409 2410 2411 2415 2420 2421 2422 2423 2424 2425 2426 2427 2428 2429 2430 2443 2469 2475 2476 2850}},
    {:page => 2, :text => "Are you of Aboriginal or Torres Strait Islander origin?", :atype => "S", :values => ["No", "Yes, Aboriginal", "Yes, Torres Straight Islander", "Yes, Aboriginal and Torres Strait Islander", "Pefer not to answer"]}
  ],
  [
    {:page => 3, :text => "Have you had a drink containing alcohol in the <strong>LAST 12 MONTHS</strong>?", :atype => "R", :values => %w{Yes No}}
  ],
  [
    {:page => 4, :text => "Are you currently receiving treatment for your drinking?", :atype => "R", :values => %w{Yes No}}
  ],
  [
    {:page => 5, :text => "How often do you have a drink containing alcohol?", :atype => "S", :values => ["Never or almost never", "Less than once a month", "Once a month", "Once every two weeks", "Once a week", "Two or three times a week", "Four or five times a week", "Six or seven times a week"]},
    {:page => 5, :text => "How many Standard Drinks containing alcohol do you have on a typical day when you are drinking? (Please refer to the Standard Drinks guide on the left)", :atype => "S", :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25-29", "30-34", "35-39", "40-49", "50 or more"]},
    {:page => 5, :text => "How often do you have 6 or more Standard Drinks on one occasion?", :atype => "S", :values => ["Never", "Once or twice a year", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "How often during the last year have you found that you were not able to stop drinking once you had started?", :atype => "S", :values => ["Never", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "How often during the last year have you failed to do what was normally expected of you because of drinking?", :atype => "S", :values => ["Never", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "How often during the last year have you needed a first drink in the morning to get yourself going after a heavy drinking session?", :atype => "S", :values => ["Never", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "How often during the last year have you had a feeling of guilt or remorse after drinking?", :atype => "S", :values => ["Never", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "How often during the last year have you been unable to remember what happened the night before because of your drinking?", :atype => "S", :values => ["Never", "Less than monthly", "Monthly", "Weekly", "Daily or almost daily"]},
    {:page => 5, :text => "Have you or someone else been injured because of your drinking?", :atype => "S", :values => ["No", "Yes, but not in the last year", "Yes, during the last year"]},
    {:page => 5, :text => "Has a relative, friend, doctor or other health worker been concerned about your drinking or suggested you cut down?", :atype => "S", :values => ["No", "Yes, but not in the last year", "Yes, during the last year"]}
  ],
  [
    {:page => 7, :text => "Have you had a drink containing alcohol in the <strong>LAST 4 WEEKS</strong>?", :atype => "R", :values => %w{Yes No}}
  ],
  [
    {:page => 8, :text => "In the LAST 4 WEEKS what is the largest number of Standard Drinks you have consumed on a single occasion?", :atype => "S", :values => [["1", "1"], ["2", "2"], ["3", "3"], ["4", "4"], ["5", "5"], ["6", "6"], ["7", "7"], ["8", "8"], ["9", "9"], ["10", "10"], ["11", "11"], ["12", "12"], ["13", "13"], ["14", "14"], ["15", "15"], ["16", "16"], ["17", "17"], ["18", "18"], ["19", "19"], ["20", "20"], ["21", "21"], ["22", "22"], ["23", "23"], ["24", "24"], ["25-29", "27"], ["30-34", "32"], ["35-39", "37"], ["40-44", "42"], ["45-49", "47"], ["50 or more", "50"]]},
    {:page => 8, :text => "Over how many hours did you drink this amount (to the nearest hour)?", :atype => "S", :values => ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24"]},
    {:page => 8, :text => "Height", :atype => "T"},
    {:page => 8, :text => "Weight", :atype => "T"}
  ],
  [
    {:page => 9, :text => "Do you find your self thinking about when you will next be able to have another drink?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Is drinking more important than anything else you might do during the day?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you feel your need for drink is too strong to control?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you plan your days around getting drink and drinking?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you drink in a particular way in order to increase the effect it gives you?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you drink morning, afternoon and evening?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you feel you have to carry on drinking once you have started?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Is getting the effect you want more important than the particular drink you use?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you want to drink more when the effect starts to wear off?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]},
    {:page => 9, :text => "Do you find it difficult to cope with life without drink?", :atype => "S", :values => [["Never", "0"], ["Sometimes", "1"], ["Often", "2"], ["Nearly always", "3"]]}
  ]
]

reseed = Question.count > 0
if reseed
  questions = Question.order(:id).all
end
pages.each do |page|
  page.each do |question|
    if reseed && !questions.empty?
      q = questions.shift
      q.update_attributes(question)
      q.save
    else
      Question.create(question)
    end
  end
end

if reseed && !questions.empty?
  questions.each do |q|
    q.delete
  end
end

unless reseed
  User.create(:login => "tony", :email => "tony@agrav.net", :password => "default", :password_confirmation => "default", :admin => true)
end
