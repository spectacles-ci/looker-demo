view: fct_order_items {
  sql_table_name: {{ _user_attributes['demo_dbt_dataset'] }}.fct_order_items ;;
  view_label: "Order Items"

  dimension_group: created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.created_at ;;
  }

  dimension: delivered_at {
    type: number
    sql: ${TABLE}.delivered_at ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

  # Step 1: Update id -> order_item_id

  dimension: order_item_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.order_item_id ;;
  }

  # Step 2: Add delivered_at dimension_group

  dimension: product_id {
    type: number
    sql: ${TABLE}.products_id ;;
  }

  dimension_group: returned {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.returned_at ;;
  }

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  dimension_group: shipped {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.shipped_at ;;
  }

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
