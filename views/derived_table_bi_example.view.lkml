view: derived_table_bi_example {
  derived_table: {
    sql: SELECT
    "users"."id" AS "users.id",
    "users"."state" AS "users.state",
    COALESCE(SUM("order_items"."sale_price"), 0) AS "order_items.total_revenue"
FROM
    "public"."order_items" AS "order_items"
    LEFT JOIN "public"."orders" AS "orders" ON "order_items"."order_id" = "orders"."id"
    LEFT JOIN "public"."users" AS "users" ON "orders"."user_id" = "users"."id"
GROUP BY
    1,
    2
ORDER BY
    3 DESC
LIMIT 100
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: users_id {
    type: number
    sql: ${TABLE}."users.id" ;;
    primary_key: yes
  }

  dimension: users_state {
    type: string
    sql: ${TABLE}."users.state" ;;
  }

  dimension: order_items_total_revenue {
    type: number
    sql: ${TABLE}."order_items.total_revenue" ;;
    value_format_name: usd
  }

  measure: average_revenue {
    type: average
    sql: ${order_items_total_revenue};;
    value_format_name: usd
  }

  set: detail {
    fields: [users_id, users_state, order_items_total_revenue]
  }
}
