SELECT
    CASE WHEN r.review_score <= 2 THEN 1 ELSE 0 END AS low_review,
    oi.freight_value,
    p.product_weight_g / 1000.0 AS product_weight_kg,
    DATE_PART('day',
        o.order_delivered_customer_date - o.order_purchase_timestamp
    ) AS delivery_days
FROM olist.orders o
JOIN olist.order_reviews r ON o.order_id = r.order_id
JOIN olist.order_items oi  ON o.order_id = oi.order_id
JOIN olist.products p      ON oi.product_id = p.product_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND p.product_weight_g IS NOT NULL
  AND oi.freight_value > 0;