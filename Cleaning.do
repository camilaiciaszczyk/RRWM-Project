
************************************************************************
************************************************************************
* AUTHOR: Camila Iciaszczyk
* DATE STARTED: September 10th, 2024
* FUNCTION: Health outcomes of older adults who live alone
* INPUT DATA: Canadian General Social Survey (gss_raw.csv)
* OUTPUT DATA: Canadian General Social Survey (gss_clean.dta)
************************************************************************
************************************************************************


import delimited "/Users/camilaiciaszczyk/Library/CloudStorage/Dropbox/Second Year/CAnD3/RRWM/gss_raw.csv", clear


*I am investigating older adults' health outcomes based on whether they live alone or not.
*In this dofile, I complete all the varaible creation/cleaning that I will use in my analysis.


*First, I am generating my dependent varaible, which is self-rated health.
*Binary variable for good self-rated health (based on srh_110)
*1 = good health (self-rated as excellent, very good, or good), 0 = not good health, . = missing
gen good_health = .
replace good_health = 1 if srh_110 == 1 | srh_110 == 2 | srh_110 == 3
replace good_health = 0 if srh_110 == 4 | srh_110 == 5
replace good_health = . if srh_110 >= 6 // for skip, don't know, refusal, not stated
*tab good_health srh_110, m

*Drop missing data on self-rated health

drop if good_health == .

*Second, I am generating my key independent variable, which is whether respondents live alone or not.
*Binary variable for living alone (based on hsdsizec)
*1 = lives alone, 0 = does not live alone
gen living_alone = .
replace living_alone = 1 if hsdsizec == 1
replace living_alone = 0 if hsdsizec >= 2 & hsdsizec <= 6
*tab living_alone hsdsizec, m

*Third, I am generating control variables. I have demographic varaibles, which include gender, age and visible minority status, and I have socioeconomic variables, which include educational attainment and income.

*Generate Demographic Control Variables:

**1.Gender

*Binary variable for female (based on sex)
*1 = female, 0 = male
gen female = sex
replace female = 1 if sex == 2
replace female = 0 if sex == 1
*tab female sex, m

**2.Age

*Categorical variable for age groups of older adults
*We will create four age groups:
*0 = 54 and below (to be dropped later in the analysis since only interested in older adults)
*1 = 55 - 64
*2 = 65 - 74
*3 = 75+

*Generate a new variable 'agegrp' for all age groups
gen agegrp = .
replace agegrp = 0 if agegr10 < 5 // Age 54 and below
replace agegrp = 1 if agegr10 == 5 // Age 55 - 64
replace agegrp = 2 if agegr10 == 6 // Age 65 - 74
replace agegrp = 3 if agegr10 == 7 // Age 75+

*Label the new 'agegrp' variable for clarity
label define agegrp 0 "54 and below" 1 "55 - 64" 2 "65 - 74" 3 "75+"
label values agegrp agegrp
*tab agegrp agegr10, m

**3.Visible minority status

*Binary variable for visible minority status (based on 'vismin')
*1 = visible minority, 0 = not a visible minority, . = missing
gen vis_minority = vismin
replace vis_minority = 1 if vismin == 1
replace vis_minority = 0 if vismin == 2
replace vis_minority = . if vismin == .a | vismin == .b // for missing data
*tab vis_minority vismin, m

*Drop missing data on vis_minority

drop if vis_minority == .

*Drop respondents aged 54 and below, since I am only interested in older adults

drop if agegrp == 0

*Generate Socioeconomic Control Variables:

**1.Educational attainment

*Categorical variable for respondents' highest level of education
*We will create five education categories:
*1 = Less than high school
*2 = High school or equivalent
*3 = Trade, college, or non-university certificate
*4 = University degree or higher
*. = missing

* Generate a new variable 'edu_level' for education categories
gen edu_level = .
replace edu_level = 1 if ehg3_01b == 1   // Less than high school
replace edu_level = 2 if ehg3_01b == 2   // High school or equivalent
replace edu_level = 3 if ehg3_01b >= 3 & ehg3_01b <= 5   // Trade, college, or non-university certificate
replace edu_level = 4 if ehg3_01b >= 6 & ehg3_01b <= 7   // University degree or higher
replace edu_level = . if ehg3_01b == 97 | ehg3_01b == 98 | ehg3_01b == 99 // for missing data

* Label the new 'edu_level' variable for clarity
label define edu_level 1 "Less than HS" 2 "HS or equivalent" 3 "Trade/College/Non-Uni" 4 "University degree+"
label values edu_level edu_level
*tab edu_level ehg3_01b, m

**2.Income level

* Categorical variable for family income
* We will create three income categories:
* 1 = Low income (Less than $50,000)
* 2 = Middle income ($50,000 to $99,999)
* 3 = High income ($100,000 or more)

* Generate a new variable 'income' for simplified income categories
gen income = .
replace income = 1 if famincg2 == 1 | famincg2 == 2 // Less than $50,000
replace income = 2 if famincg2 == 3 | famincg2 == 4 // $50,000 to $99,999
replace income = 3 if famincg2 == 5 | famincg2 == 6 // $100,000 or more

* Label the new 'income' variable for clarity
label define income 1 "Low income (<$50,000)" 2 "Middle income ($50k-$99.9k)" 3 "High income ($100k+)"
label values income income
*tab income famincg2, m

*Drop missing data on edu_level

drop if edu_level == .

* Keep only the variables we created and the person weights variable
keep living_alone good_health female agegrp vis_minority edu_level income wght_per 

*Save data as gss_clean

save "/Users/camilaiciaszczyk/Library/CloudStorage/Dropbox/Second Year/CAnD3/RRWM/gss_clean.dta", replace
