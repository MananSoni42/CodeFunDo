import csv
import datetime
from pprint import pprint
import numpy as np
import math

eq_index = {}
fld_index = {}

def get_data():
    date = str(datetime.datetime.now().date())
    with open(f'data/earthquakes-{date}.csv','r') as f:
        eq_data = list(csv.reader(f))
    for i in range(len(eq_data)):
        eq_data[i][0] = datetime.datetime.strptime(eq_data[i][0],'%Y-%m-%d')
        eq_data[i][1] = float(eq_data[i][1])
        eq_data[i][2] = float(eq_data[i][2])
        eq_data[i][3] = float(eq_data[i][3])
        eq_data[i][4] = eq_data[i][4].lower()

    #eq_data = list(np.unique(np.array(eq_data),axis=0))

    with open(f'data/flood-{date}.csv','r') as f:
        fld_data = list(csv.reader(f))
    for i in range(len(fld_data)):
        fld_data[i][0] = datetime.datetime.strptime(fld_data[i][0],'%m/%d/%Y')
        fld_data[i][1] = float(fld_data[i][1])
        fld_data[i][2] = float(fld_data[i][2])
        fld_data[i][3] = float(fld_data[i][3])
        fld_data[i][4] = float(fld_data[i][4])
        fld_data[i][5] = fld_data[i][5].lower()

    return eq_data,fld_data

def top_n_eq(x, y, n=10):
    results = sorted(eq_data, key = lambda t: ( (x-t[1])**2+(y-t[2])**2, t[0], t[3] ))[:n]
    return results

def risk_eq(x, y, r=20):

    #get_risk = lambda m,d: math.e**(0.67*m) * (d+25)**(-1.6) * (1300/980)

    r_c = r/4
    eqs = top_n_eq(x,y)
    risk = 0
    count = 0
    for eq in eqs:
        dist = np.sqrt((x-eq[1])**2 + (y-eq[2])**2)
        #print(dist,eq[3],eq[-1],eq[1],eq[2])
        if dist <= r:
            risk += eq[3]/(dist**2)
    if count != 0:
        risk = risk/count
    mag = 0
    count = 0
    for eq in eqs:
        dist = np.sqrt((x-eq[1])**2 + (y-eq[2])**2)
        if dist <= r_c:
            mag += 2*eq[3]
            count+=2
        if r_c < dist <= r:
            mag += eq[3]
            count+=1
    if count != 0:
        mag = mag/count
    if mag >= 10:
        mag = 10
    return {"magnitude": mag, "risk": risk}

def risk_fld(x, y, r=9):
    flds = []

    dist = lambda a,b: np.sqrt((x-a)**2+(y-b)**2)
    in_circ = lambda a,b: True if dist(a,b) <= r else False

    for fld in fld_data:
        if (in_circ(fld[1],fld[3]) or in_circ(fld[1],fld[4]) or
        in_circ(fld[2],fld[3]) or in_circ(fld[2],fld[4])):
            flds.append(fld)
    return {"nearest": flds[:2]}

eq_data,fld_data = get_data()
#print(risk_eq(39.79,-74.06))
#print(risk_eq(22.3,19.7))
