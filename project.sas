LIBNAME project "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project";

/* IMPORT CSV */

PROC IMPORT OUT=project.age
	DATAFILE= "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project\AgeDataset.csv"
	DBMS= CSV REPLACE;
	GETNAMES = YES;
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
	run;

/* ROUNDING 3 VARIABLES TO DISCRETE LEVEL VALUES */

DATA project.age;
	SET project.age;
	stress_lvl = round(stress_levels);
	pollution_expo = round(pollution_exposure);
	sun_expo = round(sun_exposure);
	run;

/* MAKING HISTOGRAMS FOR THE VARIABLES WITH LOWER COEFFICIENTS */

PROC UNIVARIATE DATA= project.age;
    VAR weight chol_level BMI blood_glucose stress_lvl pollution_expo sun_expo;
    HISTOGRAM / NORMAL;  
RUN;
