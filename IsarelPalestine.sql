-- DATA QUALITY CHECK
SELECT * FROM IsarelPalestine LIMIT 10; 

SELECT 
    event_id_cnty,
    SUM(CASE WHEN event_date IS NULL THEN 1 ELSE 0 END) AS Missing_Dates,
    SUM(CASE WHEN event_type IS NULL THEN 1 ELSE 0 END) AS Type_Missing,
    SUM(CASE WHEN civilian_targeting IS NULL THEN 1 ELSE 0 END) AS Targeting_Type_Missing
FROM 
    IsarelPalestine
GROUP BY 
    event_id_cnty; 

UPDATE IsarelPalestine
SET civilian_targeting = COALESCE(civilian_targeting, 'Non_Civilian_Targeting')
WHERE civilian_targeting IS NULL;


-- DESCRIPTIVE STATISTICS

-- IDENTIFYING THE FREQUENCY RATE OF FATALITIES 
SELECT fatalities, COUNT(*) as frequency 
FROM IsarelPalestine 
GROUP BY fatalities 
ORDER BY frequency DESC 
LIMIT 2;

-- IDENTIFYING THE LCOATION WITH MOST FATALITIES
SELECT location, SUM(fatalities) AS total_fatalities
FROM IsarelPalestine
GROUP BY location
ORDER BY total_fatalities DESC
LIMIT 2;

-- IDENTIFYING WHICH EVENT TYPE HAS OCCURED THE MOST 
SELECT event_type, COUNT(*) AS event_count
FROM IsarelPalestine
GROUP BY event_type
ORDER BY event_count DESC
LIMIT 1;

-- SUBEVENT ANALYSIS 
SELECT sub_event_type, COUNT(*) AS sub_event_count
FROM IsarelPalestine
GROUP BY sub_event_type
ORDER BY sub_event_count DESC;

-- SPATIAL ANALYSIS 
SELECT latitude, longitude, COUNT(*) AS event_count
FROM IsarelPalestine
GROUP BY latitude, longitude
ORDER BY event_count DESC;



-- TIME SERIES ANALYSIS 

-- DIALY AGGREGATION 

SELECT DATE(event_date) AS Date, SUM(fatalities) AS Daily_Fatalities
FROM IsarelPalestine
WHERE event_date IS NOT NULL AND event_date != 'Invalid Date' 
GROUP BY Date
ORDER BY Date;


-- MONTHLY AGGREGATION 
SELECT YEAR(event_date) AS Year, MONTH(event_date) AS Month, SUM(fatalities) AS Monthly_Fatalities
FROM IsarelPalestine
GROUP BY Year, Month
ORDER BY Year, Month;

-- YEARLY AGGREGATION 
SELECT YEAR(event_date) AS Year, SUM(fatalities) AS Yearly_Fatalities
FROM IsarelPalestine
GROUP BY Year
ORDER BY Year;

-- MOVING AVERAGE
SELECT DATE(event_date) AS Date,
       AVG(SUM(fatalities)) OVER (ORDER BY DATE(event_date) RANGE BETWEEN INTERVAL 6 DAY PRECEDING AND CURRENT ROW) AS '7_Day_Moving_Avg'
FROM IsarelPalestine
GROUP BY Date
ORDER BY Date;

-- COMPARISON OF EVENT OUTCOMES 
SELECT 
  event_type, 
  actor1, 
  AVG(fatalities) AS avg_fatalities, 
  MIN(fatalities) AS min_fatalities, 
  MAX(fatalities) AS max_fatalities, 
  COUNT(*) AS total_events
FROM 
  IsarelPalestine
GROUP BY 
  event_type, 
  actor1
ORDER BY 
  avg_fatalities DESC, 
  total_events DESC;

-- Analyzing event types and actors related to the conflict reveals which scenarios are most lethal. 
-- High average fatalities linked to specific event types or actors suggest a greater severity and risk.
--  The range and total counts of events provide context for understanding the frequency and impact of these occurrences.


--  RELATION BETWEEN CONSECUTIVE EVENTS AND FATALITIES. 
SELECT event_date, fatalities,
       LAG(fatalities, 1) OVER (ORDER BY event_date) AS previous_fatalities,
       LEAD(fatalities, 1) OVER (ORDER BY event_date) AS next_fatalities
FROM IsarelPalestine;

-- Identification of trends in fatalities over consecutive events, helping to pinpoint moments of escalation or de-escalation in the conflict's intensity
-- By comparing fatalities before and after each event,potentially indicating trigger events or significant escalations.

-- SEVERITY OF EVENTS 

SELECT event_date, actor1, fatalities,
       RANK() OVER (ORDER BY fatalities DESC) AS rank_by_fatalities
FROM IsarelPalestine;

-- ranks the conflict events by the number of fatalities, highlighting the most severe events and the actors involved

SELECT * FROM IsarelPalestine 
