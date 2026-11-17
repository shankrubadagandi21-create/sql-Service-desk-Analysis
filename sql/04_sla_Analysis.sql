-- QUESTION 6.CALCULATE SLA STATUS

SELECT
     t.ticet_id,
     t.priority,
     t.status,
    TIMESTAMPDIFF( 
       MINUTE,
       t.created_at, t.resoved_at)/60.0 as resolution_hours,
s.resolution_hour as sla_hours,
CASE
   WHEN t.resolved_at IS NULL
       THEN 'Pending'
  WHEN TIMESTAMPDIFF( 
       MINUTE,
       t.created_at,
       t.resolved_at
       ) <= s.resolution_hours *60
       THEN 'Within SLA'
       ELSE 'SLA Breached'
 END AS sla_status
FROM tickets t
JOIN sla_rules s ON t.priority = s.priority;

-- QUESTION 7. CALCULATE SLA BREACH PERCENTAGE
WITH sla_results as(
  SELECT 
        t.ticket_id,
        CASE
            WHEN t.resolved_at IS NULL
                 THEN 'pending'
            WHEN TIMESTAMPDIFF( 
                 MINUTE,
                 t.created_at, t.resolved_at
              ) <= s.resolution_hours *60
                 THEN 'Within '
              ELSE'sla Breached'
             END AS sla_status
         FROM tickets t 
         JOIN sla_rules s ON t.priority = s.priority
) 
 SELECT
       COUNT(*) AS resolved_tickets,
       SUM( 
           CASE
               WHEN sla_status = 'SLA Breached'
               THEN 1 ELSE 0
               END
        ) as breached_tickets,
         ROUND( 
              100.0 * SUM(
                     CASE
                       WHEN sla_status ='SLA Breached'
                       THEN 1 ELSE 0
                       END 
              ) / NULLIF(
                  SUM(
                      CASE
                         WHEN sla_status IN( 
                             'Within SLA',
                             'SLA Breached'
                        )
                         THEN 1 ELSE 0
                     END
                   ),
                   0
                ),
                  2
             ) as breach_percentage
FROM sla_results;

-- QUESTION 8 CALCULATE CLOSE BACKLOG

SELECT 
     st.team_name,
     COUNT(*) as open_tickets
FROM tickets t 
JOIN support_teams st 
ON t.team_id = st.team_id
WHERE t.status IN ('Open','Pending')
GROUP BY st.team_name;

select * from tickets;

-- QUESTION 9. IDENTIFY REOPENED TICKETS

SELECT
     ticket_id,
     COUNT(*) as reopened_count
FROM ticket_history
GROUP BY ticket_id
Having COUNT(*) >0;
