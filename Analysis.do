************************************************************************
************************************************************************
* AUTHOR: Camila Iciaszczyk
* DATE STARTED: September 11th, 2024
* FUNCTION: Health outcomes of older adults who live alone
* INPUT DATA: Canadian General Social Survey (gss_clean.dta)
* OUTPUT DATA: Proportions table and regression comparison table
************************************************************************
************************************************************************

*Load cleaned data
use "/Users/camilaiciaszczyk/Library/CloudStorage/Dropbox/Second Year/CAnD3/RRWM/gss_clean.dta"


*Install estout package in order to compare results of tables
ssc install estout

* Set survey weights using 'wght_per'
svyset [pw=wght_per]

*Create a proportions table for selected variables: 
*This will summarize the distribution of living arrangement, health status, gender, age group, visible minority status, education, and income.
svy: proportion living_alone good_health female agegrp vis_minority edu_level income

*Bivariate analysis: 
*Examine the relationship between the dependent variable (good_health) and the key independent variable (living_alone).
svy: logistic good_health i.living_alone
*Store the results from this bivariate model to compare later.
estimates store model1


*Bivariate analysis with additional demographic variables:
*Assess the relationship between good_health and living_alone, adding gender, age, and visible minority status to the model.
svy: logistic good_health i.living_alone i.female i.agegrp i.vis_minority
*Store the results from this extended bivariate model for comparison.
estimates store model2

*Multivariate analysis: 
*Add socioeconomic status (SES) variables (education and income) to the model, alongside living alone, gender, age, and visible minority status.
svy: logistic good_health i.living_alone i.female i.agegrp i.vis_minority i.edu_level i.income
*Store the results from this multivariate model for the final comparison.
estimates store model3

*Create a final comparison table:
*Compare the odds ratios from the bivariate models (model1 and model2) and the multivariate model (multivariable_model).
*The results are presented in a wide format for easy interpretation.
esttab model1 model2 model3, eform b(3) nonumber wide varwidth(15)

