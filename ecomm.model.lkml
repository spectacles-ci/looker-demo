connection: "bigquery_spectacles"

include: "/views/dim_products.view.lkml"
include: "/views/dim_users.view.lkml"
include: "/views/fct_order_items.view.lkml"
include: "/views/fct_orders.view.lkml"

label: "Demo - Ecommerce"

access_grant: is_emea_employee {
  user_attribute: region
  allowed_values: ["EMEA"]
}

explore: order_items {
  # required_access_grants: [is_emea_employee]
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

test: orders_items_2021 {
  explore_source: order_items {
    column: count {
      field: order_items.count_order_items
    }
    filters: [order_items.created_year: "2021"]
  }
  assert: matches_historic {
   expression: ${order_items.count} = 12045  ;;
  }
}

test: orders_items_2020 {
  explore_source: order_items {
    column: count {
      field: order_items.count_order_items
    }
    filters: [order_items.created_year: "2020"]
  }
  assert: matches_historic {
    expression: ${order_items.count} = 4797  ;;
  }
}
