#!/usr/local/bin/python

from datetime import datetime
import googlemaps
import os
import sys
import pprint
import time

gmaps = googlemaps.Client(key='AIzaSyAGJZkbHmlDgcfcIIJI73CPpAn7CXwgkYY')

# Request directions via public transit
HOME = "1793 Battersea Ct., San Jose, CA"
WORK = "285 Hamilton Ave, Palo Alto, CA"
MODE = 'driving'
MIN_TO_SEC = 60
TITLE = 'Light Traffic'

# Get current travel time
def getTime(now, isHome):
    if isHome:
        start = HOME;
        end = WORK;
    else:
        start = WORK;
        end = HOME;
    directions_result = gmaps.directions(start, end, MODE, departure_time=now)
    time = directions_result[0]['legs'][0]['duration_in_traffic']['value']
    return time

def main():
    pp = pprint.PrettyPrinter(depth=6)
    time_print_format = '{:%H:%M}';
    limit_in_min = 36
    start_home_time = 7
    end_home_time = 11
    start_work_time = 16
    end_work_time = 20

    now = datetime.now()
    if (now.hour >= start_home_time) and (now.hour <= end_home_time):
        isHome = True;
    elif (now.hour >= start_work_time) and (now.hour <= end_work_time):
        isHome = False;
    else:
        isHome = False;
    driving_time = getTime(now, isHome)
    current_time = time_print_format.format(now)
    command = 'Go {0}:'.format('Work' if isHome else 'Home')
    print('{0}{1}m@{2}'.format(command if driving_time < (limit_in_min * MIN_TO_SEC) else '', driving_time / MIN_TO_SEC, current_time))
if __name__ == '__main__':
    main()
