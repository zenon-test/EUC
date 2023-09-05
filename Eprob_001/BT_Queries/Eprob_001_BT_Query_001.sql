WITH RedressPayments AS (
    SELECT
        l.loan_id,
        l.customer_id,
        p.payment_date,
        p.payment_amount,
        p.redress_category
        rr.redress_rate,
        (p.payment_amount * rr.redress_rate / 100) AS redress_amount
    FROM
        loans2 l
    JOIN payments p ON l.loan_id = p.loan_id
    JOIN redress_rates rr ON p.payment_date BETWEEN rr.start_date AND rr.end_date
)

SELECT
    loan_id,
    customer_id,
    SUM(payment_amount) AS total_payments,
    SUM(redress_amount) AS total_redress
FROM
    RedressPayments
GROUP BY
    loan_id,
    customer_id
ORDER BY
    customer_id, loan_id;
