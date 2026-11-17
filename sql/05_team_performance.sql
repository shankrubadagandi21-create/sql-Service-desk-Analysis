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

-- QUESTION 10 Rank support teams by backing
WITH team_backlog as(
    SELECT 
        st.team_id,
        st.team_name,
        COUNT(t.ticket_id) as open_tickets
FROM support_teams st
LEFT JOIN tickets t  ON st.team_id = t.team_id
          AND t.status IN ('Open,','Pending')
GROUP BY st.team_id, st.team_name
)
SELECT 
    team_name,
    open_tickets,
    
    DENSE_RANK() OVER (ORDER BY open_tickets DESC) as backlog_rank
FROM team_backlog;
