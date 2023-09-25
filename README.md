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

# Get all support tables

```
lokaliteter_1<-query_table(con,columns = c("Lregnr","Feltoperasjonsnr","Loknr","Loknavn","Lokangivelse","Lokbeskrivelse"), table="LOKALITETER") # klarer ikke alt. Blir det for mye? Klarer ikke Feltopersajonsnr, x, Y, X33, Y33
lokaliteter_2<-query_table(con,columns = c("Lregnr","Feltoperasjonsnr","Loknr","Elveavsnitt", "UTM_koordinat", "UTM_datum", "UTM_sone", "X", "Y", "X33", "Y33", "Lengdegrad", "Breddegrad","Merknader", "SSMA_TimeStamp"), table="LOKALITETER")
lokaliteter_3<-query_table(con,columns = c("Lregnr","Feltoperasjonsnr","Loknr","VaarSone"), table="LOKALITETER")
lokaliteter<-lokaliteter_1 %>% full_join(lokaliteter_2) %>% full_join(lokaliteter_3)
```

```
drift_1<-query_table(con,table = "Driftsopplysninger", columns = c("DriftsopplysningerID","Lregnr", "Feltoperasjonsnr", "Feltaar","Loknr","Dato", "Dato_fra","Dato_til","Fangstperiode","RedskapID"))
drift_2<-query_table(con,table = "Driftsopplysninger", columns = c("DriftsopplysningerID","Lregnr", "Feltoperasjonsnr", "Feltaar","Loknr","Dato",  "Dato_fra","Dato_til","RedskapspesifikasjonID" ,"Vannforing",             "Vannstand"  ,            "Vanntemperatur"     ,    "Elfiskeomgang" ,         "Antall_elfiskeomganger" ,"Areal"   ,               "N_Laks"    ,             "N_Aure"   ,              "N_Roye"))
drift_3<-query_table(con,table = "Driftsopplysninger", columns = c("DriftsopplysningerID","Lregnr", "Feltoperasjonsnr", "Feltaar","Loknr","Dato", "Dato_fra","Dato_til","N_Aal"  ,  "N_Merket_Laks",  "N_Merket_Aure",     "N_Merket_Røye"    ,     "N_Gjenfanget_Laks" ,     "N_Gjenfanget_Aure"  ,    "N_Gjenfanget_Roye"  ,    "Merknader"    ,          "SSMA_TimeStamp"  ))
drift<-drift_1 %>% full_join(drift_2) %>% full_join(drift_3)
```

```
objekter<-query_table(con,table="Objekter")
arter<-query_table(con, table="Art_form")
redskap<-query_table(connection=con,table = "Redskap")
redskapspes<-query_table(con,table = "Redskapspesifikasjon")
feltoperasjoner<-query_table(con,table = "feltoperasjoner")
kjonn<-query_table(con,table = "Kjonn")
kjonnstadium<-query_table(con,table = "Kjonnsstadium")
kvalitet_skjellprove<-query_table(con,table = "kvalitet_skjellprove")
Livsstadium<-query_table(connection=con,table = "Livsstadium")
vill_oppdrett<-query_table(con,table = "Vill_oppdrett")
visuell_vill_oppdrett<-query_table(con,table = "visuell_Vill_oppdrett")
circuli<-query_table(con,table = "Circulimalinger")
merknad<-query_table(con,table = "Merknad")
skjellavleser<-query_table(con,table = "Skjellavleser")
feltaar<-query_table(con,table = "FELTAAR")
skader_defekter<-query_table(con,table = "Skader_defekter")
kjonnsbestmet<-query_table(con,table="Kjonnsbest_metode")
storrelse_aal<-query_table(con,table="Storrelsesgruppe_aal")
admaktivitet<-query_table(con,table="AdmAktivitet")
```

# Get parts of the ENKELTFISK dataset - example Altaelva

```
alta_data <- query_table(connection = con, table="ENKELTFISK", columns = c("Lregnr","EnkeltfiskID", "Feltaar", "Dato","Art_formID","KjonnID","Vill_oppdrettetID","RedskapID"), condition = "Lregnr = 200212")
```

# Join ENKELTFISK dataset with support tables - use full_join()

```
alta_data %>% 
full_join(objekter %>% select(Lregnr,Objektnavn)) %>% 
  select(Objektnavn,everything()) %>% 
  full_join(arter) %>% 
  full_join(kjonn) %>%
  full_join(redskap) %>% 
  filter(Feltaar!="")
```

# Acknowledgments

This R package has been created by [Benjamin Cretois](https://www.nina.no/english/Contact/Employees/Employee-info?AnsattID=15849).



