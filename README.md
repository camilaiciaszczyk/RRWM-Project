Study Description
This study examines the relationship between solo-living and health among older adults. Using the General Social Survey, Cycle 31, from 2017, analyses find that older adults living alone are more likely to self-report poor health compared to older adults not living alone. Below, all the information needed to reproduce these analyses is found. 

Data Description

Data Source Availability Statement

Data used for this project is from the Canadian General Social Survey, Cycle 31, year 2017. Data was obtained through ODESI, a service provided by the Ontario Council of University Libraries (https://search1.odesi.ca/#/Links to an external site.).

As part of McGill University, the CAnD3 initiative has a license to use the data for the purposes of training. Those outside of McGill university should not use the data provided through CAnD3's training activities for purposes not related to their CAnD3 training.

Fellows who belong to another DLI institution should re-download the data using the ODESI site using the login provided by their institution if they wish to make use of the data for other purposes.

Citation
Statistics Canada. 2020. General Social Survey, Cycle 31, 2017 [Canada]: Family (version 2020-09). Statistics Canada [producer and distributor], accessed September 10, 2021. ID: gss-12M0025-E-2017-c-31

Files Included

Analysis.do – Completes all the analysis for the output tables
Cleaning.do – Cleans the data and all the variables used for analysis

Instructions for Data Preparation and Analysis
In order to replicate the findings of the project, download the zip file. This zip file contains a folder called “CAnD3 RRWM”, which is your working directory. 

Software Requirements
Stata/SE 18.0 for Mac (Apple Silicon)
Revision 30 Aug 2023
Copyright 1985-2023 StataCorp LLC
Package Required for Stata
estout

Machine Information
The analyses were conducted using macOS Sonoma 14.6.1

Project Outline

Research question: Do older adults who live alone report worse health outcomes compared to those who do not live alone?

Program
1.	Clean and generate the dependent variable (self-rated health) and key independent variable (whether the respondent lives alone).
2.	Clean and generate control variables:
Demographic control variables: gender, age, visible minority status.
Socioeconomic control variables: educational attainment, income level.
3.	Save the cleaned dataset.
4.	Generate analysis do-file.
5.	Create a weighted summary table with all variables (t)
6.	Create logistic regression models (t):
Bivariate regression: dependent variable on living alone.
Multivariate regression: include all control variables.

Program with Associated Do-Files
1.	Clean and generate the dependent and key independent variables
I.	Dependent variable is the self-rated health variable (srh_110) recoded into a new binary variable called good_health. Categorize the respondents' self-assessed health into two categories: "good health" (combining those who rate their health as 1excellent, 2very good, or 3good) and "not good health" (combining those who rate their health as 4fair or 5poor). Missing values or outliers are left as missing.
II.	Drop missing data for good_health.
III.	The key independent variable is household size variable (hsdsizec) recoded into a new binary variable called living_alone. Categorize respondents based on whether they live alone or not. Respondents who have a household size of 1 are categorized as "living alone" (coded as 1), while those with a household size between 2 and 6 are categorized as "not living alone" (coded as 0). Missing values or outliers are left as missing.
IV.	Drop the missing data for living_alone.

2.	Clean and generate control variables
I.	The demographic control variables include gender, age group, and visible minority status. Gender is recoded into a binary variable (female), based on the original variable (sex), where respondents who identify as female are coded as 1, and males are coded as 0. Age is categorized into four age groups (agegrp), based on the original variable (agegr10): 0 for respondents aged 54 and below (who will later be dropped), 1 for those aged 55–64, 2 for those aged 65–74, and 3 for those aged 75 and older. Respondents under the age of 55 are excluded from the analysis. Visible minority status is recoded into a binary variable (vis_minority), based on the original variable (vismin), where respondents who identify as visible minorities are coded as 1, and those who do not are coded as 0. 
II.	Drop the missing values for the demographic control variables (only visible minority has missing) and for agegrp 0 because we are only interested in observing older adults.
III.	The socioeconomic control variables include educational attainment and income level. Educational attainment is recoded into a categorical variable (edu_level), based on the original variable (ehg3_01b), with four categories: 1 for less than high school, 2 for high school or equivalent, 3 for trade, college, or non-university certificate, and 4 for a university degree or higher. Income level is recoded into a categorical variable (income), based on the original variable (famincg2), with three categories: 1 for low income (less than $50,000), 2 for middle income ($50,000 to $99,999), and 3 for high income ($100,000 or more). 
IV.	Drop the missing values for the socioeconomic control variables (only education level has missing).

3.	Save the cleaned dataset.
I.	Keep only created variables.
II.	Keep person survey weights (wght_per)
III.	Save data “gss_clean”

4.	Generate analysis do-file.
I.	Use cleaned data file “gss_clean”
II.	Install estout (for comparison tables)
III.	Set survey using wght_per

5.	Create a weighted summary table with all variables (t)
I.	Generate a list of summary statistics for key variables: living arrangement (living_alone), health status (good_health), gender (female), age group (agegrp), visible minority status (vis_minority), educational attainment (edu_level), and income level (income).
II.	Apply the survey weights using the variable wght_per.

6.	Create logistic regression models (t)
I.	Perform a bivariate logistic regression to analyze the relationship between living alone and good health, using good_health as the outcome variable and living_alone as the key independent variable. Store the model for later comparison table.
II.	Perform additional bivariate logistic regressions to explore the relationship between good_health as the outcome variable and living_alone as the key independent variable and control for demographic variables such as gender (female), age group (agegrp), and visible minority status (vis_minority). This model is also stored for later comparison table.
III.	Perform final multivariate logistic regression by adding socioeconomic status (SES) variables, including educational attainment (edu_level) and income level (income), along with the demographic predictors. This multivariate model assesses the combined effect of living arrangements, demographics, and SES on health outcomes. This model is stored for later comparison table.
IV.	Generate a comparison table for both the bivariate and multivariate models (the three store models from above), allowing for comparison of the effects of each predictor on good health. The results are presented in terms of odds ratios for each model.
