# Define the database connection to be used for this model.
connection: "thelook"

# include all the views
include: "/views/**/*.view"

# Datagroups define a caching policy for an Explore. To learn more,
# use the Quick Help panel on the right to see documentation.

#test comment

datagroup: ecommerce_srangala_default_datagroup {
  sql_trigger: SELECT CURRENT_DATE();;
  max_cache_age: "24 hour"
}

persist_with: ecommerce_srangala_default_datagroup

# Explores allow you to join together different views (database tables) based on the
# relationships between fields. By joining a view into an Explore, you make those
# fields available to users for data analysis.
# Explores should be purpose-built for specific use cases.

# To see the Explore you’re building, navigate to the Explore menu and select an Explore under "Ecommerce Srangala"

explore: dt_employees {}
explore: dt_people {
  join: account_executive {
    from: dt_employees
    view_label: "Account Executive"
    type: inner
    relationship: one_to_one
    sql_on: ${account_executive.id} = ${dt_people.id} ;;
    #required_joins: [dt_employees]
  }
}

explore: dt_employees_nullpk {}
explore: dt_people_nullpk {
  join: account_executive_nullpk {
    from: dt_employees_nullpk
    view_label: "Account Executive"
    type: inner
    relationship: one_to_one
    sql_on: ${account_executive_nullpk.id} = ${dt_people_nullpk.id} ;;
    #required_joins: [dt_employees_nullpk]
  }

}



explore: inventory_items {
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: order_items {
  join: orders {
    type: left_outer
    sql_on: ${order_items.order_id} = ${orders.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }

  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
  join: user_facts {
    type: left_outer
    sql_on: ${orders.user_id} = ${user_facts.user_id} ;;
    relationship: many_to_one
  }
  join: products {
    type: left_outer
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
    relationship: many_to_one
  }

  join: derived_table_bi_example {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: orders {
  join: users {
    type: left_outer
    sql_on: ${orders.user_id} = ${users.id} ;;
    relationship: many_to_one
  }
}

explore: product_facts {
  join: products {
    type: left_outer
    sql_on: ${product_facts.product_id} = ${products.id} ;;
    relationship: many_to_one
  }
}

explore: user_facts {}

# To create more sophisticated Explores that involve multiple views, you can use the join parameter.
# Typically, join parameters require that you define the join type, join relationship, and a sql_on clause.
# Each joined view also needs to define a primary key.

explore: products {}

explore: users {}
