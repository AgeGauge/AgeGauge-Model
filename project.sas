LIBNAME project "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project";

/* IMPORT CSV */

PROC IMPORT OUT=project.age
	DATAFILE= "/home/u61567054/homework/project/ProjectDataORIGINAL.csv"
	DBMS= CSV REPLACE;
	GETNAMES = YES;
	OPTIONS VALIDVARNAME=V7;
	run;

PROC CONTENTS DATA=project.age;
	run;
	
/* RENAME VARIABLE FOR EASE OF USE */

DATA project.age;
	SET project.age;
	RENAME Height__cm_ = height;
	RENAME Weight__kg_ = weight;
	RENAME Blood_pressure__s_d_ = bp;
	RENAME Cholesterol_level__mg_dL_ = chol_level;
	RENAME Blood_glucose_level__mg_dL_ = blood_glucose;
	RENAME var8 = bone_density;
	RENAME Hearing_ability__dB_ = hearing_ability;
	RENAME Physical_activity_level = activity_level;
	RENAME Age__years_ = age;
	run;

 /* SEPARATE BLOOD PRESSURE VALUES */

DATA project.age;
	SET project.age;
	systolic=SUBSTR(bp,1,3);
	diastolic=SUBSTR(bp,5);
	systolic_bp=INPUT(systolic,4.);
	diastolic_bp=INPUT(diastolic,4.);
	run;

/* ROUNDING 3 VARIABLES TO DISCRETE LEVEL VALUES */

DATA project.age;
	SET project.age;
	stress_lvl = round(stress_levels);
	pollution_expo = round(pollution_exposure);
	sun_expo = round(sun_exposure);
	run;

 /* CHECK CORRELATION COEFFICIENT OF ALL QUANTITATIVE VARIABLES */

TITLE "CORRELATION COEFFICIENTS FOR ALL NUMERIC VARIABLES";
PROC CORR DATA=project.age;
	VAR age height weight systolic_bp diastolic_bp chol_level bmi blood_glucose stress_lvl sun_expo
	pollution_expo cognitive_function bone_density vision_sharpness hearing_ability;
	run;

/* MAKING HISTOGRAMS FOR THE VARIABLES WITH WEAK COEFFICIENT COEFFICIENTS */

TITLE "HISTOGRAMS FOR WEAK CORRELATION COEFFICIENTS";
PROC UNIVARIATE DATA= project.age;
    VAR weight chol_level BMI blood_glucose stress_lvl pollution_expo sun_expo;
    HISTOGRAM / NORMAL;
    run;

/*  MAKING HISTOGRAMS FOR THE VARIABLES WITH STRONG COEFFICIENT COEFFICIENTS */

TITLE "HISOGRAMS FOR STRONGER CORRELATION COEFFICIENTS";
PROC UNIVARIATE DATA=project.age NOPRINT;
	VAR age systolic_bp diastolic_bp bone_density vision_sharpness hearing_ability cognitive_function;
	HISTOGRAM / NORMAL;
	run;
	
/* MAKE FREQUENCY TABLES FOR CATAGORICAL DATA */

TITLE "FREQUENCY TABLES FOR CATAGORICAL DATA";
PROC FREQ DATA=project.age;
	table gender activity_level smoking_status alcohol_consumption diet chronic_diseases medication_use
	family_history mental_health_status sleep_patterns income_level education_level;
	run;

/* MAKE BAR CHART FOR CATAGORICAL VARIABLES */

TITLE "BAR CHARTS FOR CATAGORICAL VARIABLES";
PROC SGPLOT DATA=project.age;
	VBAR activity_level;
	run;
	
PROC SGPLOT DATA=project.age;
	VBAR gender;
	run;

PROC SGPLOT DATA=project.age;
	VBAR smoking_status;
	run;

PROC SGPLOT DATA=project.age;
	VBAR alcohol_consumption;
	run;

PROC SGPLOT DATA=project.age;
	VBAR diet;
	run;

PROC SGPLOT DATA=project.age;
	VBAR chronic_diseases;
	run;

PROC SGPLOT DATA=project.age;
	VBAR medication_use;
	run;

PROC SGPLOT DATA=project.age;
	VBAR family_history;
	run;

PROC SGPLOT DATA=project.age;
	VBAR mental_health_status;
	run;

PROC SGPLOT DATA=project.age;
	VBAR sleep_patterns;
	run;

PROC SGPLOT DATA=project.age;
	VBAR income_level;
	run;

PROC SGPLOT DATA=project.age;
	VBAR education_level;
	run;

/* FIND DESCRIPTIVE STATISTICS FOR STRONG CORRELATION VARIABLES */;

TITLE "DESCRIPTIVE STATISTICS FOR STRONG CORRELATION COEFFICIENT VARIABLES";
PROC MEANS DATA=project.age N MEAN STDDEV MEDIAN Q1 Q3 QRANGE MIN MAX RANGE;
	VAR systolic_bp diastolic_bp vision_sharpness hearing_ability cognitive_function bone_density;
	run;

/* SCATTERPLOTS FOR VARIABLES WITH >|0.5| CORRELATION COEFFICIENT */;

TITLE "SCATTERPLOTS FOR VARIABLES WITH >|0.5| CORRELATION COEFFICIENT";
PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age systolic_bp;
	run;
	
PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age diastolic_bp;
	run;
	
PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age cognitive_function;
	run;
	
PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age bone_density;
	run;

PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age vision_sharpness;
	run;

PROC CORR DATA=project.age PLOTS=SCATTER (NVAR=ALL);
	VAR age hearing_ability;
	run;

/* SIDE-BY-SIDE BOXPLOTS FOR CATEGORICAL VARIABLES */

PROC SGPLOT DATA=project.age;
    VBOX age / category=activity_level;
    title 'Side-by-Side Box Plots of Age by Activity Level';
    xaxis label='Activity Level';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=gender;
    title 'Side-by-Side Box Plots of Age by Gender';
    xaxis label='Gender';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=smoking_status;
    title 'Side-by-Side Box Plots of Age by Smoking Status';
    xaxis label='Smoking Status';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=alcohol_consumption;
    title 'Side-by-Side Box Plots of Age by Alcohol Consumption';
    xaxis label='Alcohol Consumption';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=diet;
    title 'Side-by-Side Box Plots of Age by Diet';
    xaxis label='Diet';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=chronic_diseases;
    title 'Side-by-Side Box Plots of Age by Chronic Diseases';
    xaxis label='Chronic Diseases';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=medication_use;
    title 'Side-by-Side Box Plots of Age by Medication Use';
    xaxis label='Medication Use';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=family_history;
    title 'Side-by-Side Box Plots of Age by Family History';
    xaxis label='Family History';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=mental_health_status;
    title 'Side-by-Side Box Plots of Age by Mental Health Status';
    xaxis label='Mental Health Status';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=sleep_patterns;
    title 'Side-by-Side Box Plots of Age by Sleep Patterns';
    xaxis label='Sleep Patterns';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=income_level;
    title 'Side-by-Side Box Plots of Age by Income Level';
    xaxis label='Income Level';
    yaxis label='Age (years)';
run;

PROC SGPLOT DATA=project.age;
    VBOX age / category=education_level;
    title 'Side-by-Side Box Plots of Age by Education Level';
    xaxis label='Education Level';
    yaxis label='Age (years)';
run;

/* ANOVA Tests for All Categoical Variables */;
PROC ANOVA DATA=project.age;
	CLASS gender;
	MODEL age = gender;
	MEANS gender / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS activity_level;
	MODEL age = activity_level;
	MEANS activity_level / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS smoking_status;
	MODEL age = smoking_status;
	MEANS smoking_status / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS alcohol_consumption;
	MODEL age = alcohol_consumption;
	MEANS alcohol_consumption / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS diet;
	MODEL age = diet;
	MEANS diet / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS chronic_diseases;
	MODEL age = chronic_diseases;
	MEANS chronic_diseases / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS medication_use;
	MODEL age = medication_use;
	MEANS medication_use / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS family_history;
	MODEL age = family_history;
	MEANS family_history / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS mental_health_status;
	MODEL age = mental_health_status;
	MEANS mental_health_status / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS education_level;
	MODEL age = education_level;
	MEANS education_level / TUKEY;
	run;
	
PROC ANOVA DATA=project.age;
	CLASS income_level;
	MODEL age = income_level;
	MEANS income_level / TUKEY;
	run;
	
/* T-Tests for all quantitative variables */;

PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*height;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*weight;
	run;

PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*chol_level;
	run;

PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*BMI;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*blood_glucose;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*bone_density;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*vision_sharpness;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*hearing_ability;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*cognitive_function;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*systolic_bp;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*diastolic_bp;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*stress_lvl;
	run;

PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*pollution_expo;
	run;
	
PROC TTEST DATA=project.age ALPHA=0.05;
	PAIRED age*sun_expo;
	run;

/* DATA TRANSFORMATION FOR CATEGORICAL VARIABLES */

 DATA project.age;
    SET project.age;
    if smoking_status = 'Current' then smoking_status_current = 1; else smoking_status_current = 0;
    if smoking_status = 'Former' then smoking_status_former = 1; else smoking_status_former = 0;

    if education_level = 'None' then education_rank = 0;
    else if education_level = 'High School' then education_rank = 1;
    else if education_level = 'Undergraduate' then education_rank = 2;
    else if education_level = 'Postgraduate' then education_rank = 3;
run;


/* MULTIPLE LINEAR REGRESSION MODEL */

PROC REG DATA=project.age;
    MODEL Age = smoking_status_current smoking_status_former education_rank height weight chol_level BMI blood_glucose bone_density vision_sharpness hearing_ability cognitive_function systolic_bp diastolic_bp stress_lvl pollution_expo;
	run;
