#!/usr/bin/env python3

import hug
import pymssql
import os

DSN="mssql+pymssql://sa_Fiskedatabasen_r:lro2nvqE8hVCnN2rzMdp@ninsql07.nina.no/Fiskedatabasen"

conn = pymssql.connect('ninsql07.nina.no', 'sa_Fiskedatabasen_r', 'lro2nvqE8hVCnN2rzMdp', 'Fiskedatabasen')

# First line of the schema

@hug.get()
def enkeltfisk(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM ENKELTFISK;")
    return cursor.fetchall()

@hug.get()
def redskap(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Redskap;")
    return cursor.fetchall()

@hug.get()
def redskapspesifikasjon(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Redskapspesifikasjon;")
    return cursor.fetchall()

@hug.get()
def driftsopplynsninger(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM DRIFTSOPPLYNSNINGER;")
    return cursor.fetchall()

@hug.get()
def kvalitet_skjellprove(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Kvalitet_skjellprove;")
    return cursor.fetchall()

# Second column of the schema

@hug.get()
def feltaar(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM FELTAAR;")
    return cursor.fetchall()

@hug.get()
def feltoperasjoner(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM FELTOPERASJONER;")
    return cursor.fetchall()

@hug.get()
def enkeltfisk(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM ENKELTFISK;")
    return cursor.fetchall()

@hug.get()
def circulimalinger(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Circulimalinger;")
    return cursor.fetchall()


# Third column of the schema

@hug.get()
def grupper_av_fisk(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM GRUPPER_AV_FISK;")
    return cursor.fetchall()

def merknad(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Merknad;")
    return cursor.fetchall()


def lokaliteter(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM LOKALITETER;")
    return cursor.fetchall()

# Fourth column of the schema

@hug.get()
def vill_oppdrett(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Vill_oppdrett;")
    return cursor.fetchall()

@hug.get()
def storrelsesgruppe_aal(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Storrelsesgruppe_aal;")
    return cursor.fetchall()

@hug.get()
def skjellavleser(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Skjellavleser;")
    return cursor.fetchall()

@hug.get()
def objekter(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Objekter;")
    return cursor.fetchall()

@hug.get()
def livsstadium(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Livsstadium;")
    return cursor.fetchall()

@hug.get()
def kjonnsstadium(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Kjonnsstadium;")
    return cursor.fetchall()

@hug.get()
def kjonnsbest_metode(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Kjonnsbest_metode;")
    return cursor.fetchall()

@hug.get()
def kjonn(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Kjonn;")
    return cursor.fetchall()

@hug.get()
def objekter(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Objekter;")
    return cursor.fetchall()

@hug.get()
def art_form(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM Art_form;")
    return cursor.fetchall()

@hug.get()
def admaktivitet(output=hug.output_format.json):
    cursor = conn.cursor(as_dict=True)
    cursor.execute("SELECT * FROM AdmAktivitet;")
    return cursor.fetchall()
