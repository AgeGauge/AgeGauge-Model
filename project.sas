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

/* MAKE SUBSET DATASETS FOR CATAGORICAL VARIABLES AND AGE */

DATA project.age_gender_male (KEEP=Individual_ID KEEP=age KEEP=gender);
	SET project.age;
	IF gender='Male';
	run;
	
DATA project.age_gender_female (KEEP=Individual_ID KEEP=age KEEP=gender);
	SET project.age;
	IF gender='Female';
	run;
	
DATA project.age_activty_low (KEEP=Individual_ID KEEP=age KEEP=activity_level);
	SET project.age;
	IF activity_level='Low';
	run;

DATA project.age_activty_moderate (KEEP=Individual_ID KEEP=age KEEP=activity_level);
	SET project.age;
	IF activity_level='Moderate';
	run;	
	
DATA project.age_activty_high (KEEP=Individual_ID KEEP=age KEEP=activity_level);
	SET project.age;
	IF activity_level='High';
	run;
	
DATA project.age_smoking_never (KEEP=Individual_ID KEEP=age KEEP=smoking_status);
	SET project.age;
	IF smoking_status='Never';
	run;
	
DATA project.age_smoking_former (KEEP=Individual_ID KEEP=age KEEP=smoking_status);
	SET project.age;
	IF smoking_status='Former';
	run;
		
DATA project.age_smoking_current (KEEP=Individual_ID KEEP=age KEEP=smoking_status);
	SET project.age;
	IF smoking_status='Current';
	run;
	
DATA project.age_alcohol_none (KEEP=Individual_ID KEEP=age KEEP=alcohol_consumption);
	SET project.age;
	IF alcohol_consumption='None';
	run;
	
DATA project.age_alcohol_freq (KEEP=Individual_ID KEEP=age KEEP=alcohol_consumption);
	SET project.age;
	IF alcohol_consumption='Frequent';
	run;
	
DATA project.age_alcohol_occasion (KEEP=Individual_ID KEEP=age KEEP=alcohol_consumption);
	SET project.age;
	IF alcohol_consumption='Occasional';
	run;
	
DATA project.age_diet_balanced (KEEP=Individual_ID KEEP=age KEEP=diet);
	SET project.age;
	IF diet='Balanced';
	run;
	
DATA project.age_diet_lowcarb (KEEP=Individual_ID KEEP=age KEEP=diet);
	SET project.age;
	IF diet='Low-carb';
	run;
	
DATA project.age_diet_veg (KEEP=Individual_ID KEEP=age KEEP=diet);
	SET project.age;
	IF diet='Vegetarian';
	run;
	
DATA project.age_diet_highfat (KEEP=Individual_ID KEEP=age KEEP=diet);
	SET project.age;
	IF diet='High-fat';
	run;
	
DATA project.age_chronic_hyper (KEEP=Individual_ID KEEP=age KEEP=chronic_diseases);
	SET project.age;
	IF chronic_diseases='Hypertension';
	run;
	
DATA project.age_chronic_heart (KEEP=Individual_ID KEEP=age KEEP=chronic_diseases);
	SET project.age;
	IF chronic_diseases='Heart Disease';
	run;
DATA project.age_chronic_diabetes (KEEP=Individual_ID KEEP=age KEEP=chronic_diseases);
	SET project.age;
	IF chronic_diseases='Diabetes';
	run;

DATA project.age_chronic_none (KEEP=Individual_ID KEEP=age KEEP=chronic_diseases);
	SET project.age;
	IF chronic_diseases='None';
	run;
	
DATA project.age_medication_none (KEEP=Individual_ID KEEP=age KEEP=Medication_use);
	SET project.age;
	IF medication_use='None';
	run;

DATA project.age_medication_occasion (KEEP=Individual_ID KEEP=age KEEP=Medication_use);
	SET project.age;
	IF medication_use='Occasional';
	run;
	
DATA project.age_medication_reg (KEEP=Individual_ID KEEP=age KEEP=Medication_use);
	SET project.age;
	IF medication_use='Regular';
	run;

DATA project.age_history_heartdisease (KEEP=Individual_ID KEEP=age KEEP=family_history);
	SET project.age;
	IF family_history = 'Heart Disease';
	run;
 
DATA project.age_history_diabetes (KEEP=Individual_ID KEEP=age KEEP=family_history);
	SET project.age;
	IF family_history = 'Diabetes';
	run;
 
DATA project.age_history_hypertension (KEEP=Individual_ID KEEP=age KEEP=family_history);
	SET project.age;
	IF family_history = 'Hypertension';
	run;
 
DATA project.age_history_none (KEEP=Individual_ID KEEP=age KEEP=family_history);
	SET project.age;
	IF family_history = 'None';
	run;

DATA project.age_mental_poor (KEEP=Individual_ID KEEP=age KEEP=Mental_Health_Status);
	SET project.age;
	IF Mental_Health_Status = 'Poor';
	run;
 
DATA project.age_mental_fair (KEEP=Individual_ID KEEP=age KEEP=Mental_Health_Status);
	SET project.age;
	IF Mental_Health_Status = 'Fair';
	run;
DATA project.age_mental_good (KEEP=Individual_ID KEEP=age KEEP=Mental_Health_Status);
	SET project.age;
	IF Mental_Health_Status = 'Good';
	run;
 
DATA project.age_mental_excellent (KEEP=Individual_ID KEEP=age KEEP=Mental_Health_Status);
	SET project.age;
	IF Mental_Health_Status = 'Exce';
	run;

DATA project.age_sleep_insomnia (KEEP=Individual_ID KEEP=age KEEP=Sleep_Patterns);
	SET project.age;
	IF Sleep_Patterns = 'Insomnia';
	run;
 
DATA project.age_sleep_excessive (KEEP=Individual_ID KEEP=age KEEP=Sleep_Patterns);
	SET project.age;
	IF Sleep_Patterns = 'Excessive';
	run;
 
DATA project.age_sleep_normal (KEEP=Individual_ID KEEP=age KEEP=Sleep_Patterns);
	SET project.age;
	IF Sleep_Patterns = 'Normal';
	run;
 
DATA project.age_income_low (KEEP=Individual_ID KEEP=age KEEP=Income_Level);
	SET project.age;
	IF Income_Level = 'Low';
	run;
 
DATA project.age_income_medium (KEEP=Individual_ID KEEP=age KEEP=Income_Level);
	SET project.age;
	IF Income_Level = 'Medium';
	run;
 
DATA project.age_income_high (KEEP=Individual_ID KEEP=age KEEP=Income_Level);
	SET project.age;
	IF Income_Level = 'High';
	run;

DATA project.age_education_highschool (KEEP=Individual_ID KEEP=age KEEP=Education_Level);
	SET project.age;
	IF Education_Level = 'High School';
	run;
 
DATA project.age_education_undergraduate (KEEP=Individual_ID KEEP=age KEEP=Education_Level);
	SET project.age;
	IF Education_Level = 'Undergraduate';
	run;
 
DATA project.age_education_postgraduate (KEEP=Individual_ID KEEP=age KEEP=Education_Level);
	SET project.age;
	IF Education_Level = 'Postgraduate';
	run;
 
DATA project.age_education_none (KEEP=Individual_ID KEEP=age KEEP=Education_Level);
	SET project.age;
	IF Education_Level = 'None';
	run;
 
 /*  QUARTILE INFORMATION FOR QUANTITATIVE VARIABLES */

TITLE "QUARTILE INFORMATION FOR NUMERIC VARIABLES";
PROC MEANS DATA=project.age Q1 Q3;
    VAR age systolic_bp diastolic_bp bone_density vision_sharpness hearing_ability cognitive_function;
    OUTPUT OUT=project.quartile 
	Q1(age)=Q1_age Q1(systolic_bp)=Q1_systolic_bp Q1(diastolic_bp)=Q1_diastolic_bp
        Q1(bone_density)=Q1_bone_density Q1(vision_sharpness)=Q1_vision_sharpness
        Q1(hearing_ability)=Q1_hearing_ability Q1(cognitive_function)=Q1_cognitive_function
        Q3(age)=Q3_age Q3(systolic_bp)=Q3_systolic_bp Q3(diastolic_bp)=Q3_diastolic_bp
        Q3(bone_density)=Q3_bone_density Q3(vision_sharpness)=Q3_vision_sharpness
        Q3(hearing_ability)=Q3_hearing_ability Q3(cognitive_function)=Q3_cognitive_function;
	RUN;

/* FIND DESCRIPTIVE STATISTICS FOR STRONG CORRELATION VARIABLES */;

TITLE "DESCRIPTIVE STATISTICS FOR STRONG CORRELATION COEFFICIENT VARIABLES";
PROC MEANS DATA=project.age N MEAN STDDEV MEDIAN Q1 Q3 QRANGE MIN MAX RANGE;
	VAR systolic_bp diastolic_bp vision_sharpness hearing_ability cognitive_function bone_density;
	run;

/* HISTOGRAMS FOR VARIABLES WITH STRONG CORRELATION COEFFICIENT */

TITLE "HISTORGRAMS FOR STRONG CORRELATION COEFFICIENT VARIABLES";	
PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM systolic_bp;
	run;
	
PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM diastolic_bp;
	run;
	
PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM vision_sharpness;
	run;
	
PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM hearing_ability;
	run;
	
PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM cognitive_function;
	run;

PROC UNIVARIATE DATA=project.age NOPRINT;
	CLASS age;
	HISTOGRAM bone_density;
	run;
