For my inaugural portfolio project, I sourced a dataset from Kaggle focusing on the Israel-Palestine conflict, which I then meticulously cleansed using Excel to ensure data quality. Subsequently, I imported the refined dataset into MySQL Workbench, where I leveraged SQL queries to extract a range of insights. This project enhanced my proficiency in MySQL but also highlighted the importance of  data cleansing and analysis in deriving meaningful insights from complex datasets.

Data Quality Check: Verified the quality of the dataset by identifying missing values in crucial columns such as event_date, event_type, and civilian_targeting. Ensured data integrity by updating null values in civilian_targeting with a default value 'Non_Civilian_Targeting'.

Descriptive Statistics: Conducted an initial exploration to understand the distribution of fatalities and identify the locations with the highest number of fatalities, providing insights into the most affected areas.

Event Type Analysis: Determined the most frequently occurring event type in the dataset, highlighting the predominant nature of conflict events.

Sub-Event Type Analysis: Analyzed the distribution of sub-event types to identify specific patterns within broader event categories, shedding light on the granularity of conflict dynamics.

Spatial Analysis: Investigated the geographical distribution of conflict events using latitude and longitude data to pinpoint hotspots of high conflict intensity.

Time Series Analysis:
•	Daily Aggregation: Analyzed daily fatality counts to observe short-term fluctuations and identify significant days with high casualty rates.
•	Monthly Aggregation: Examined trends in fatalities on a monthly basis to understand seasonal or monthly variations in conflict intensity.
•	Yearly Aggregation: Evaluated yearly changes in fatalities to assess the long-term trend of conflict severity.
•	Moving Average: Applied a 7-day moving average to smooth daily fatality data, highlighting underlying trends free from daily volatility.

Comparison of Event Outcomes: Compared average, minimum, and maximum fatalities across different event types and actors, offering insights into the lethality associated with specific scenarios and participants in the conflict.

Consecutive Event Fatality Analysis: Utilized LAG and LEAD window functions to compare fatalities of consecutive events, providing a perspective on the immediate impact of events and potential escalation or de-escalation patterns.

Severity Ranking: Employed the RANK window function to prioritize events by the number of fatalities, identifying the most severe incidents and involved actors, which is crucial for understanding the magnitude of specific conflict events.
