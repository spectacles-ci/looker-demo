view: dylans_orders {
  sql_table_name: {{ _user_attributes['demo_dbt_dataset'] }}.fct_order_items ;;
  view_label: "Order Items"

  dimension: id {
    type: number
    hidden: yes
    sql: ${TABLE}.order_item_id ;;
  }

  dimension: was_delivered {
    type: yesno
    sql: ${TABLE}.was_delivered ;;
  }

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
}
