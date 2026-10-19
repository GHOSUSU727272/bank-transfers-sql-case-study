-- 1. Successful transfers with sender and recipient.
SELECT t.id, sender.full_name AS sender, receiver.full_name AS receiver,
       t.amount, t.created_at
FROM transfers t
JOIN accounts sa ON sa.id = t.sender_account_id
JOIN customers sender ON sender.id = sa.customer_id
JOIN accounts ra ON ra.id = t.receiver_account_id
JOIN customers receiver ON receiver.id = ra.customer_id
WHERE t.status = 'completed'
ORDER BY t.created_at DESC;

-- 2. Senders with total completed outgoing amount above 20,000.
SELECT c.id, c.full_name, SUM(t.amount) AS total_sent
FROM customers c
JOIN accounts a ON a.customer_id = c.id
JOIN transfers t ON t.sender_account_id = a.id
WHERE t.status = 'completed'
GROUP BY c.id, c.full_name
HAVING SUM(t.amount) > 20000
ORDER BY total_sent DESC;

-- 3. All customers, including those without completed transfers.
SELECT c.id, c.full_name,
       COUNT(t.id) AS completed_transfer_count,
       COALESCE(SUM(t.amount), 0) AS completed_amount
FROM customers c
LEFT JOIN accounts a ON a.customer_id = c.id
LEFT JOIN transfers t ON t.sender_account_id = a.id AND t.status = 'completed'
GROUP BY c.id, c.full_name
ORDER BY completed_amount DESC;

-- 4. Completed transfer count by date.
SELECT CAST(t.created_at AS DATE) AS transfer_date,
       COUNT(*) AS transfer_count,
       SUM(t.amount) AS total_amount
FROM transfers t
WHERE t.status = 'completed'
GROUP BY CAST(t.created_at AS DATE)
ORDER BY transfer_date;

-- 5. Customer transfers larger than their own average successful outgoing amount.
SELECT t.*
FROM transfers t
WHERE t.status = 'completed'
  AND t.amount > (
    SELECT AVG(t2.amount)
    FROM transfers t2
    WHERE t2.sender_account_id = t.sender_account_id
      AND t2.status = 'completed'
  );
