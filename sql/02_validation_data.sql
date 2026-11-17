-- STEP 2. DATA VALIDATION
SELECT COUNT(*) FROM customers;
SELECT COUNT(*) FROM tickets;
SELECT COUNT(*) FROM support_teams;
SELECT COUNT(*) FROM sla_rules;
SELECT COUNT(*) FROM ticket_history;

-- STEP 2. VALIDATE TICKET DATA
SELECT *
FROM ticketS
WHERE created_at IS NOT NULL;
SELECT *
FROM tickets
WHERE resolved_at < created_at;
SELECT *
FROM tickets
WHERE priority NOT IN (
      'Critical',
      'High',
      'Medium',
      'Low'
);
