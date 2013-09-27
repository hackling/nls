select date_trunc('hour', created_at) AS hour, seller_id, sum(amount) as total from transactions where transaction_type = 'Selling' group by 1, 2 ;
