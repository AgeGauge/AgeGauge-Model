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
