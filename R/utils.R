#' Vector to string
#'
#' Transform a list of chosen column to a single string (essential for SQL query)
#' @export
transform_to_string <- function(column) {
  return(paste0("\"", paste(column, collapse = "\", \""), "\""))
}

#' Get column string
#'
#' Gives a SQL compliant string for filtering the columns. If no columns are selected, return ALL columns
#' @export
return_columns <- function(columns){
  if (length(columns != 0) && columns != "*"){
    columns <- transform_to_string(columns)
  }
  # If not, just select all
  else if (columns == "*"){
    columns = columns
  }
  else{
    print("Please select existing columns")
  }
  return(columns)
}
