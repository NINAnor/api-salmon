# api-salmon

Project that sets up an API in Python for retrieving the data of Laksdatabasen in R.

## Function to load data from Laksdatabasen in R

You can use this helper function to load the table you want from *laksdatabasen*.

You may need to install the packages `httr` and `jsonlite` beforehand.


```
library(httr)
library(jsonlite)

laksdata_load <- function(table){
  query <- GET(paste0("http://nindocker02.nina.no:8050/", table))
  data <- fromJSON(rawToChar(query$content))
  return(data)
}

```

For example, if I want to load the table `FELTAAR` I would write it such that:

```
feltaar <- laksdata_load(feltaar)
```

You can find the correspondance table name / query below

# List of table names 

- ENKELTFISK -> enkeltfisk
- Redskap -> redskap
- Redskapspesifikasjon -> redskapspesifikasjon
- DRIFTSOPPLYNSNINGER -> driftsopplynsninger
- Kvalitet_skjellprove -> kvalitet_skjellprove
- FELTAAR -> feltaar
- FELTOPERASJONER -> feltoperasjoner
- ENKELTFISK -> enkeltfisk (This one is large and will take time to load in R memory)
- Circulimalinger -> circulimalinger
- GRUPPER_AV_FISK -> grupper_av_fisk
- Merknad -> merknad
- LOKALITETER -> lokaliteter
- Vill_oppdrett -> vill_oppdrett
- Storrelsesgruppe_aal -> storrelsesgruppe_aal
- Skjellavleser -> skjellavleser
- Objekter -> objekter
- Livsstadium -> livsstadium
- Kjonnsstadium -> kjonnsstadium
- Kjonnsbest_metode -> kjonnsbest_metode
- Kjonn -> kjonn
- Art_form -> art_form
- AdmAktivitet -> admaktivitet
