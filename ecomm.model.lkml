connection: "bigquery_spectacles"

include: "/views/dimensions/dim_products.view.lkml"
include: "/views/dimensions/dim_users.view.lkml"
include: "/views/facts/fct_order_items.view.lkml"
include: "/views/facts/fct_orders.view.lkml"

label: "Demo - Ecommerce"

explore: order_items {
  label: "Demo - Orders"
  fields: [ALL_FIELDS*]
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

explore: dim_products {
  view_label: "Demo - All Products"
  label: "Demo - All Products"
  fields: [ALL_FIELDS*]
}
