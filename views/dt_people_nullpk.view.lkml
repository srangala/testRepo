view: dt_people_nullpk {
  derived_table: {
    sql: SELECT 1 AS id, 'John Doe' AS fullname
            UNION
            SELECT 2 AS id, 'Patricia Red' AS fullname
            UNION
            SELECT 3 AS id, 'Irving King' AS fullname
            UNION
            SELECT 4 AS id, 'Alicia White' AS fullname
            UNION
            SELECT 5 AS id, 'Julian Keys ' AS fullname
            UNION
            SELECT null AS id, null AS fullname
             ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
    primary_key: yes
  }

  dimension: fullname {
    type: string
    sql: ${TABLE}.fullname ;;
  }

  set: detail {
    fields: [id, fullname]
  }
}
