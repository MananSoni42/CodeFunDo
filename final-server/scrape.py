import csv
import bs4
import datetime
import urllib.request
from pprint import pprint
import re

num = 7
days_bef = 5

### --- PAGE 1 --- ###

url = 'https://www.world-earthquakes.com/'
source = urllib.request.urlopen(url).read()
soup = bs4.BeautifulSoup(source,'lxml')

eqs = []
tables = soup('table')

for table in tables:
    rows = table('tr')
    for row in rows:
        cols = row('td')
        cols = [col.text for col in cols]
        if cols:
            eqs.append(cols)

date = str(datetime.datetime.now().date())
with open(f'data/earthquakes-{date}.csv','a') as f:
    writer = csv.writer(f)
    #writer.writerow(['date', 'latitude', 'longitude', 'magnitude', 'country'])
    for eq in eqs:
        lat = float(eq[1])
        lon = float(eq[2])
        mag = float(eq[3])
        cont = eq[5]
        date = eq[0].split('T')[0].split(',')[0]
        writer.writerow([date, lat, lon, mag, cont])

risks = []
r_table = soup('ul',class_='w3-ul')[1]
for row in r_table('li'):
    risks.append(row.text.split()[1:])

date = str(datetime.datetime.now().date())
with open(f'data/risk-{date}.csv','w') as f:
    writer = csv.writer(f)
    for risk in risks:
        cont = ' '.join(risk[:-1])
        mag = risk[-1].replace('%','').replace('(','').replace(')','')
        writer.writerow([cont, mag])

### --- PAGE 2 --- ###

for i in range(1,num+1):
    url = 'https://www.emsc-csem.org/Earthquake/world/?view=' + str(i)
    source = urllib.request.urlopen(url).read()
    soup = bs4.BeautifulSoup(source,'lxml')

    eqs = []
    tables = soup('tbody',id='tbody')
    for table in tables:
        rows = table('tr')
        for row in rows:
            cols = row('td')
            cols = [col.text.replace('\xa0','') for col in cols if col.text]
            if cols:
                eqs.append(cols)

    date = str(datetime.datetime.now().date())
    with open(f'data/earthquakes-{date}.csv','a') as f:
        writer = csv.writer(f)
        for eq in eqs:
            #print(eq)
            try:
                date = re.search(r'[0-9]{4}-[0-9]{2}-[0-9]{2}', eq[0]).group()
                if eq[2].lower() == 'n':
                    lat = float(eq[1])
                if eq[2].lower() == 's':
                    lat = -1*float(eq[1])
                if eq[4].lower() == 'e':
                    lon = float(eq[3])
                if eq[4].lower() == 'w':
                    lon = -1*float(eq[3])
                mag = eq[7]
                cont = eq[8]
                writer.writerow([date, lat, lon, mag, cont])
            except AttributeError:
                pass

### --- PAGE 3 --- ###
date_bef = str(datetime.datetime.now().date() - datetime.timedelta(days=days_bef))
date = str(datetime.datetime.now().date())
url_date_bef = ''.join(date_bef.split('-'))
url_date = ''.join(date.split('-'))

url = f'http://www.gdacs.org/flooddetection/data.aspx?from={url_date_bef}&to={url_date}&type=html&alertlevel=red&datatype=4DAYS'
source = urllib.request.urlopen(url).read()
soup = bs4.BeautifulSoup(source,'lxml')

flds = []
tables = soup('table')
for table in tables:
    rows = table('tr')
    for row in rows:
        cols = row('td')
        cols = [col.text.replace('\xa0','') for col in cols if col.text]
        if cols:
            flds.append(cols)

flds = flds[1:]
date = str(datetime.datetime.now().date())
with open(f'data/flood-{date}.csv','w') as f:
    writer = csv.writer(f)
    for fld in flds:
        try:
            cont = fld[2]
            lon_min = fld[8]
            lon_max = fld[9]
            lat_min = fld[10]
            lat_max = fld[11]
            date = fld[fld.index("4DAYS")+1].split(' ')[0]
            if not any(letter.isdigit() for letter in cont):
                writer.writerow([date,lat_min,lat_max,lon_min,lon_max,cont])
        except:
            pass
