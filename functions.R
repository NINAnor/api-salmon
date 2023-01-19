library(DBI)
library(assertthat)
library(odbc)
library(tidyverse)

###############################################################
# Function to connect to the fish database without any effort #
###############################################################
fiskdatabasen_connect <- function(){
  
  con <- DBI::dbConnect(odbc(),
                        Driver = "SQL Server", 
                        server = "ninsql07.nina.no",
                        database = "Fiskedatabasen",
                        trusted_connection = TRUE)
  return(con)
}

########################
# SOME UTILS FUNCTIONS #
########################
get_columns <- function(con, table){
  columns <- dbListFields(con, table)
  return(columns)
}

transform_to_string <- function(column) {
  return(paste0("\"", paste(column, collapse = "\", \""), "\""))
}

#############################################
# QUERY THE TABLE -> ABSTRACT THE SQL QUERY #
#############################################
return_columns <- function(columns){
  
  # If some columns are specified convert the string
  if (!is.na(columns)){
    columns <- transform_to_string(columns)
  }
  # If not, just select all
  else if (is.na(columns)){
    columns = "*"
  }
  else{
    print("Please select existing columns")
  }
}

query_table <- function(connection, table, columns = NA, condition=NA){
  
  columns <- return_columns(columns)
  
  # If no conditions is specified, select everything
  if (is.na(condition)){
    result <- dbGetQuery(connection, paste('SELECT', columns, 'FROM', table))
  }
  # If conditions are specified filter with regards to the condition
  else if (is.string(condition)){
    result <- dbGetQuery(connection, paste('SELECT', columns, 'FROM', table, 'WHERE', condition))
  }
  else{
    print("This is an invalid condition. Please note that the function can only support 
          a single condition.")
  }
  # Make into a dataset
  result <- as_tibble(result)
  
  # Return the results of the query
  return(result)
}


