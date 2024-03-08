#' Fiskdatabasen connection
#'
#' Connection to fiskdatabasen
#' @return A connection to the database
#' @examples 
#' con<-fiskdatabasen_connect()
#' @export
fiskdatabasen_connect <- function() {
  # Detect the operating system
  os <- Sys.info()["sysname"]

  # Initialize driver name variable
  driverName <- NA

  # Define the driver name based on the OS
  if (os == "Windows") {
    driverName <- "SQL Server"
  } else if (os == "Linux") {
    driverName <- "FreeTDS"
  } else {
    stop("Unsupported operating system.")
  }

    con <- DBI::dbConnect(odbc::odbc(),
                          Driver = driverName,
                          server = "ninsql07.nina.no",
                          database = "Fiskedatabasen",
                          port=1433,
                          trusted_connection = TRUE)
  return(con)
}

#' Get columns
#'
#' Get the columns from a specific table
#' @param con table
#' @return A vector containing the names of the columns of the specific table
#' @examples 
#' cols<-get_columns(con, "Redskap")
#' @export
get_columns <- function(con, table){
  columns <- DBI::dbListFields(con, table)
  return(columns)
}


#' Get tables
#'
#' Get the tables from the fiskdatabasen
#' @return A vector containing the names of all the tables from the fiskdatabase
#' @examples 
#' cols<-get_tables()
#' @export
get_tables <- function(){
  tables <- c("Objekter", "Art_form", "LOKALITETER", "Redskap", "Redskapspesifikasjon",
              "feltoperasjoner", "Driftsopplysninger", "Kjonn", "Kjonnsstadium",
              "kvalitet_skjellprove", "Livsstadium", "Vill_oppdrett", "visuell_Vill_oppdrett",
              "Circulimalinger", "Skader_defkter", "FELTAAR", "Merknad", "Skjellavleser",
              "ENKELTFISK", "Storrelsesgruppe_aal", "AdmAktivitet")
  return(tables)
  }

#' Query table
#'
#' Function that query the table and return the expected dataframe
#' @param connection, table, columns, condition
#' @return A single string
#' @examples 
#' alta_data<-query_table(connection = con, table="ENKELTFISK", columns = c("Lregnr","EnkeltfiskID", "Feltaar", "Dato","KjonnID","Vill_oppdrettetID"), condition = "Lregnr = 200212")
#' @export
query_table <- function(connection, table, columns = "*", condition=NA){
  
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
  result <- tibble::as_tibble(result)
  
  # Return the results of the query
  return(result)
}


