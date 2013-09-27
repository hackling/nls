select date_trunc('hour', created_at) AS hour, transaction_type, sum(amount) as total from transactions group by 1, 2;
