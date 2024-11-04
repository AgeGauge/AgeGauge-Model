libname project "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project";

/* Import CSV */
PROC IMPORT OUT=project.age
	DATAFILE= "C:\Users\Brino\OneDrive\Desktop\Fall 2024\Extra\Datasets\Project\Train.csv"
	DBMS= CSV REPLACE;
	GETNAMES = YES;
	RUN;

PROC CONTENTS DATA=project.age;
	RUN;

 */ Check for Missing Values */;
 
PROC MEANS DATA=project.age n nmiss;
	run;

*/ LABEL VARIABLES THAT NEED INFORMATION */;

DATA project.age;
	SET project.age;
	LABEL Height__cm_ = "Height (in cm)";
	LABEL Weight__kg_ = "Weight (in kg)";
	LABEL Blood_pressure__s_d_ = 'Blood Pressure (s/d)';
	LABEL Cholesterol_level__mg_dL_ = 'Cholesterol Level (mg/dL)';
	LABEL Blood_glucose_level__mg_dL_ = 'Blood Glucose Level (mg/dL)';
	LABEL Hearing_ability__db = 'Hearing Ability in Decibels';
	LABEL Sun_exposure = 'Average Sun Exposure per Week';
	LABEL var8 = "Bone Density in Grams per Cubic Centimeter";
	LABEL Stress_levels = 'Self-reported Stress Levels';
	LABEL Sleep_patterns = 'Average Hours of Sleep per Night';
	LABEL Cognitive_Function = 'Self-reported Cognitive Function';
	Label Age__years_ = "Age in Years";
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
	RENAME Hearing_ability__dB = hearing_ability;
	RENAME Physical_activity_level = activity_level;
	RENAME Age__years_ = Age;
	run;
 
