#' Fiskdatabasen connection
#'
#' Connection to fiskdatabasen
#' @return A connection to the database
#' @examples 
#' con <- fiskdatabasen_connect()
#' @export
fiskdatabasen_connect <- function(){
  
  con <- DBI::dbConnect(odbc::odbc(),
                        Driver = "SQL Server", 
                        server = "ninsql07.nina.no",
                        database = "Fiskedatabasen",
                        trusted_connection = TRUE)
  return(con)
}

#' Get columns
#'
#' Get the columns from a specific table
#' @param con table
#' @return A vector containing the names of the columns of the specific table
#' @examples 
#' cols <- get_columns(con, "Redskap")
#' @export
get_columns <- function(con, table){
  columns <- DBI::dbListFields(con, table)
  return(columns)
}

#' Query table
#'
#' Function that query the table and return the expected dataframe
#' @param connection, table, columns, condition
#' @return A single string
#' @examples 
#' alta_data <- query_table(connection = con, table="ENKELTFISK", columns = c("Lregnr","EnkeltfiskID", "Feltaar", "Dato","KjonnID","Vill_oppdrettetID"), condition = "Lregnr = 200212")
#' @export
query_table <- function(connection, table, columns = NA, condition=NA){
  
  columns <- return_columns(columns)
  
  # If no conditions is specified, select everything
  if (is.na(condition)){
    result <- DBI::dbGetQuery(connection, paste('SELECT', columns, 'FROM', table))
  }
  # If conditions are specified filter with regards to the condition
  else if (assertthat::is.string(condition)){
    result <- DBI::dbGetQuery(connection, paste('SELECT', columns, 'FROM', table, 'WHERE', condition))
  }
  else{
    print("This is an invalid condition. Please note that the function can only support 
          a single condition.")
  }
  # Make into a dataset
  result <- tidyverse::as_tibble(result)
  
  # Return the results of the query
  return(result)
}


