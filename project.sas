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
	
PROC CORR DATA=project.age;
	VAR age height weight systolic_bp diastolic_bp chol_level bmi blood_glucose stress_lvl sun_expo
	pollution_expo cognitive_function bone_density vision_sharpness hearing_ability;
	run;

/* MAKING HISTOGRAMS FOR THE VARIABLES WITH WEAK COEFFICIENT COEFFICIENTS */

PROC UNIVARIATE DATA= project.age;
    VAR weight chol_level BMI blood_glucose stress_lvl pollution_expo sun_expo;
    HISTOGRAM / NORMAL;  
RUN;

/*  MAKING HISTOGRAMS FOR THE VARIABLES WITH STRONG COEFFICIENT COEFFICIENTS */

PROC UNIVARIATE DATA=project.age NOPRINT;
	VAR age systolic_bp diastolic_bp bone_density vision_sharpness hearing_ability cognitive_function;
	HISTOGRAM / NORMAL;
	run;

 /* MAKE BAR CHART FOR CATAGORICAL VARIABLES */

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
	VBAR mentalhealth_status;
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
