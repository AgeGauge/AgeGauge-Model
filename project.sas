libname project "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project";

/* IMPORT CSV */
PROC IMPORT OUT=project.age
	DATAFILE= "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project\AgeDataset.csv"
	DBMS= CSV REPLACE;
	GETNAMES = YES;
	run;

proc contents data=project.age;
	run;

*/ LABEL VARIABLES THAT NEED INFORMATION */;

DATA project.age;
	SET project.age;
	LABEL Height__cm_ = "HEIGHT (IN CM)";
	LABEL Weight__kg_ = "WEIGHT (IN KG)";
	LABEL Blood_pressure__s_d_ = 'BLOOD PRESSURE (S/D)';
	LABEL Cholesterol_level__mg_dL_ = 'CHOLESTEROL LEVEL (MG/DL)';
	LABEL Blood_glucose_level__mg_dL_ = 'BLOOD GLUCOSE LEVEL (MG/DL)';
	LABEL Hearing_ability__db = 'HEARING ABILITY (IN DB)';
	LABEL Sun_exposure = 'AVERAGE SUN EXPOSURE PER WEEK';
	LABEL var8 = "BONE DENSITY IN GRAMS PER CUBIC CENTIMETER";
	LABEL Stress_levels = 'SELF-REPORTED STRESS LEVELS';
	LABEL Sleep_patterns = 'AVERAGE HOURS OF SLEEP PER NIGHT';
	LABEL Cognitive_Function = 'SELF-REPORTED COGNITIVE FUNCTION';
	Label Age__years_ = "AGE IN YEARS";
	run;
	
PROC CONTENTS DATA=project.age;
	run;
	
*/ RENAME VARIABLE FOR EASE OF USE */;

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
	RENAME Gender = gender;
	RENAME BMI = bmi;
	RENAME Visual_Sharpness = visual_sharpness;
	RENAME Smoking_Status = smoking_status;
	RENAME Alcohol_consumption = alcohol_consumption;
	RENAME Diet = diet;
	RENAME Chronic_Diseases = chronic_diseases;
	RENAME Medication_Use = medication_use;
	RENAME Family_History = family_history;
	RENAME Cognitive_Function = cognitive_function;
	RENAME Mental_Health_Status = mentalhealth_status;
	RENAME Sleep_Patterns = sleep_patterns;
	RENAME Stress_Levels = stress_levels;
	RENAME Pollution_Exposure = pollution_expo;
	RENAME Sun_Exposure = sun_expo;
	RENAME Education_Level = education_level;
	RENAME Income_Level = income_level;
	run;
