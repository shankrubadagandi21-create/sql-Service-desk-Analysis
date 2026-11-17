-- STEP 3.PERFORM TICKET  ANALYSIS
-- QUESTON 1.TOTAL TICKETS
SELECT 
      COUNT(*) AS total_tickets
FROM tickets;

-- QUESTION 2.TICKETS BY STATUS
SELECT status,
       COUNT(*) as total_tickets
FROM ticket_history
GROUP BY status;

-- QUESTION 3. TICKETS BY SUPP0RT_TEAM
SELECT st.team_name,
       COUNT(*) as total_tickets
FROM support_teams st 
LEFT JOIN tickets t ON st.team_id = t.team_id
GROUP BY st.team_name;

-- QUESTION 4. CALCULATE RESILUTION TIME
SELECT 
      ticket_id,
      TIMESTAMPDIFF(
           MINUTE,
           created_at,resolved_at)/60.0 AS resolution_houres
FROM tickets
WHERE resolved_at IS NOT NULL;

-- QUESTION 5. CALCULATE AVERAGE RESOLUTION TIMR BY PRIORITY
SELECT 
        priority,
        AVG(
        TIMESTAMPDIFF( 
            MINUTE,
             created_at, 
             resolved_at
             )/60.0
        )AS average_resoluton_houres
FROM tickets
WHERE resolved_at IS NOT NULL
GROUP BY priority;
