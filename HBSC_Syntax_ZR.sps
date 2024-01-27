* Encoding: UTF-8.

* Create a new binary variable 'feellow_binary'.
COMPUTE feellow_binary = (feellow = 1 OR feellow = 2).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS feellow_binary 0 'Less often' 1 'Almost every day or more than once a week'.
EXECUTE.

* Create a new binary variable 'nervous_binary'.
COMPUTE nervous_binary = (nervous = 1 OR nervous = 2).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS nervous_binary 0 'Less often' 1 'Almost every day or more than once a week'.
EXECUTE.


* Create a new binary variable 'sleep_binary'.
COMPUTE sleepdifficulty_binary = (sleepdifficulty = 1 OR sleepdifficulty = 2).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS sleepdifficulty_binary 0 'Less often' 1 'Almost every day or more than once a week'.
EXECUTE.

* Create a new binary variable 'irritable_binary'.
COMPUTE irritable_binary = (irritable = 1 OR irritable = 2).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS irritable_binary 0 'Less often' 1 'Almost every day or more than once a week'.
EXECUTE.

* Create a new binary variable 'low_and_nervous_binary'.
COMPUTE low_and_nervous_binary = (feellow_binary = 1 AND nervous_binary = 1).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS low_and_nervous_binary 0 'Felt neither or just one' 1 'Felt both low and nervous'.
EXECUTE.

* Create a new binary variable 'low_nervous_irritable_binary'.
COMPUTE low_nervous_irritable_binary = (feellow_binary = 1 AND nervous_binary = 1 AND irritable_binary = 1).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS low_nervous_irritable_binary 0 'Felt neither or just one' 1 'Felt low, nervous, and irritable'.
EXECUTE.




* Apply the sample weights.
WEIGHT BY sampleweights.

* Crosstabs to calculate the percentage of teens by country and gender who reported feeling low.
CROSSTABS
  /TABLES=countryno BY feellow_binary
  /FORMAT=AVALUE TABLES
  /CELLS=ROW.

* Apply the sample weights.
WEIGHT BY sampleweights.

* Crosstabs to calculate the percentage of teens by country and gender who reported feeling low.
CROSSTABS
  /TABLES=countryno BY nervous_binary
  /FORMAT=AVALUE TABLES
  /CELLS=ROW.


* Apply the sample weights.
WEIGHT BY sampleweights.

* Crosstabs to calculate the percentage of teens by country and gender who reported feeling low.
CROSSTABS
  /TABLES=countryno BY irritable_binary
  /FORMAT=AVALUE TABLES
  /CELLS=ROW.

* Apply the sample weights.
WEIGHT BY sampleweights.

* Crosstabs to calculate the percentage of teens by country and gender who reported feeling low.
CROSSTABS
  /TABLES=countryno BY sleepdifficulty_binary
  /FORMAT=AVALUE TABLES
  /CELLS=ROW.


* Apply the sample weights.
WEIGHT BY sampleweights.

* Crosstabs to calculate the percentage of teens by country and gender who reported feeling nervous.
CROSSTABS
  /TABLES=countryno BY low_nervous_irritable_binary
  /FORMAT=AVALUE TABLES
  /CELLS=ROW.


DATASET ACTIVATE DataSet1.
RELIABILITY
  /VARIABLES=feellow irritable nervous sleepdifficulty
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /STATISTICS=SCALE CORR
  /SUMMARY=TOTAL.

* Apply the sample weights.
WEIGHT BY sampleweights.

DATASET ACTIVATE DataSet10.
MEANS TABLES= Avg_Distress BY countryno
  /CELLS=MEAN COUNT.



**AVG Distress Score
    
COMPUTE Avg_Distress = MEAN(feellow, irritable, nervous, sleepdifficulty).
EXECUTE.

* Value labels for the new binary variable.
VALUE LABELS Avg_Distress  1 'Every day' 5 'Rarely or never'.
EXECUTE.
