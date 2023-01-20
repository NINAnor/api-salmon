# api-salmon :fish:

A small R package that abstracts most of the database manipulation and SQL queries for
NINA's fish database.

# Install and load the package

:warning: the name of the repo and the library you call in R vary slightly :warning:

```
devtools::install_github("https://github.com/NINAnor/api-salmon")
library(apisalmon)
```

# How to use it

## Connect to database and summarise the information

It is possible to connect to the fish database using:

```
con <- fiskdatabasen_connect()
```

After establishing the connection it is possible to list the names of the tables present in the database using the function
`get_tables()` as follow:

```
get_tables()
```

The `con` object represent the connection to the database. Now that the connection is set up we can inspect some properties of the fish database.
For examples, it is possible to get the names of the columns of `ENKELTFISK` using the function `get_columns` as displayed below:

```
get_columns(con, "ENKELTFISK")
```

## Get a dataframe

After establishing the connection it is possible to query the database with the function 
`query_table`. 

The `query_table` function take different arguments:

- **connection**: the object that connects to the database. In our example `con`
- **table**: The table to extract the data from. In our example `ENKELTFISK`
- **columns** (optional): The columns of the table that is to be extracted. If no columns are specified, the full table will be extracted.
- **condition** (optional): Used to filter the table given a condition. **NOTE** that only one condition can be specified. This is useful for a first filtering of the dataset, then `dplyr` or base R can be used to further filter.

See examples below:

```
# Get the full Reskap dataset
redskap <- query_table(connection = con, table="Redskap")

# Get parts of the ENKELTFISK dataset
alta_data <- query_table(connection = con, table="ENKELTFISK", columns = c("Lregnr","EnkeltfiskID", "Feltaar", "Dato","KjonnID","Vill_oppdrettetID"), condition = "Lregnr = 200212")
```

# Acknowledgments

This R package has been created by [Benjamin Cretois](https://www.nina.no/english/Contact/Employees/Employee-info?AnsattID=15849) and [Henrik H. Berntsen](https://www.nina.no/kontakt/Ansatte/Ansattinformasjon.aspx?AnsattID=15368)



