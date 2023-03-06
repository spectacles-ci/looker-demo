view: fct_orders {
  sql_table_name: {{ _user_attributes['demo_dbt_dataset'] }}.fct_orders ;;
  view_label: "Orders"
  label: "Orders"

  dimension: order_id {
    type: number
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.order_id ;;
  }

  dimension_group: created {
    type: time
    description: "The date/timestamp the order was created."
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

  dimension: order_status {
    type: string
    description: "The status of the order."
    sql: ${TABLE}.order_status ;;
  }

  dimension: store_name {
    type: string
    sql: ${TABLE}.store_name ;;
  }

  dimension: user_id {
    type: number
    description: "The ID of the associated user."
    sql: ${TABLE}.user_id ;;
  }

  measure: count_orders {
    type: count
    description: "A count of the number of orders."
    drill_fields: []
  }
}
