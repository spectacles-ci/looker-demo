connection: "bigquery_spectacles"

include: "/views/*.view.lkml"

explore: order_items {
  label: "Demo - Orders"
  from: fct_order_items
  join: fct_orders {
    relationship: many_to_one
    sql_on: ${fct_orders.order_id} = ${order_items.order_id} ;;
  }
  join: dim_products {
    relationship: many_to_one
    sql_on: ${dim_products.product_id} = ${order_items.product_id} ;;
  }
  join: dim_users {
    relationship: many_to_one
    sql_on: ${fct_orders.user_id} = ${dim_users.user_id} ;;
  }
}
