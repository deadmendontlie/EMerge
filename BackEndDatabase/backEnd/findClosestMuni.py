# Author: George Clelland
# Project: Emerge
# Class: Senior Project
# Professor: James Strate
# Purpose: Takes input of all municipalities and parses GPS coordinates. Then parses input report GPS
# and calls haversine to compare distances between the report GPS and all of the munis; assigning the
# report to the closest one. If either municipality or report GPS is not in expected format, defaults
# to municipality_id 1

import math

#Stores parsed { municipality_id : <String> GPS coords } for all Emerge municipalities
muniDict = {}

# Gets all municipality data and stores municipality_id and GPS_coord in a dictionary.
# Recieves: <dict> municipalities, <String> reportGPS
def getMunis(municipalities, reportGPS):
    global muniDict
    closestMuni = 1 # Default muni if muni or report GPS coordinates are invalid

    # Try/catch to compensate for invalid muni/report GPS data format
    try:
        for i in municipalities:
            # Create dictionary {'municipality_id' : 'GPS_coord'} with all municipalities
            # Removes gps coord extraneous labels (Lat:, Long:) & leaves only comma-separated numeric string
            muniDict.update( { i['municipality_id'] : 
                                i['GPS_coord'].replace("Lat: ", "").replace("Long: ", "") } ) 

            # Finish GPS coordinates parse and convert to floating point list format 
            for key in muniDict:
                newCoord = (str(muniDict[key]).split(","))
                muniDict.update( { key : 
                    [float(newCoord[0].replace("[", "")), float(newCoord[1].replace("]", "")) ] } )

        #convert reportGPS to list coordinate
        reportGPS = reportGPS.replace("Lat: ", "").replace("Long: ", "")
        reportGPSList = reportGPS.split(",")

        # Check each municipality and update closest muni if current muni is closer than previous best
        closestDistance = 9999999
        for key in muniDict:     
            distance = haversine([float(muniDict[key][0]), float(muniDict[key][1])], 
                                 [float(reportGPSList[0]), float(reportGPSList[1])])

            # Check each muni/report distance and update muni if this muni is closer than previous ones
            if distance <= closestDistance:
                closestDistance = distance
                closestMuni = key

    # Catches any parse errors for either muni or report gps and outputs error message to console
    except:
        print("GPS parsing error")

    # No matter what, transmit municipality_id to assign report to
    finally:
        return(closestMuni)

#end get_munis


# Finds distance between two GPS coordinates in meters over spherical globe.
# Function adopted from https://janakiev.com/blog/gps-points-distance-python/
# Receives: List<float><float> municipality GPS coord, List<float><float> report GPS coord
# Returns: <float> distance between the two coordinates
def haversine(coord1, coord2):
    R = 6372800  # Earth radius in meters
    lat1, lon1 = coord1
    lat2, lon2 = coord2
    
    phi1, phi2 = math.radians(lat1), math.radians(lat2)
    dphi       = math.radians(lat2 - lat1)
    dlambda    = math.radians(lon2 - lon1)
    
    a = math.sin(dphi/2)**2 + \
        math.cos(phi1)*math.cos(phi2)*math.sin(dlambda/2)**2
    
    return 2*R*math.atan2(math.sqrt(a), math.sqrt(1 - a))

#end of haversine
