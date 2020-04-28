import math

muniDict = {}

# Gets all municipality data and stores municipality_id and GPS_coord in a dictionary
def getMunis(municipalities, reportGPS):
    global muniDict
    closestMuni = 1 # Default muni if muni or report GPS coordinates are invalid

    try:
        for i in municipalities:
            # Create dictionary {'municipality_id' : 'GPS_coord'} with all municipalities
            # Removes gps coord extraneous labels (Lat:, Long:) & leaves only comma-separated numeric string
            muniDict.update( { i['municipality_id'] : 
                                i['GPS_coord'].replace("Lat: ", "").replace("Long: ", "") } ) 

            # Finish GPS coordinates parse and convert to floating point list format 
            # Lat = newCoord[0]
            # Long = newCoord[1]
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
            if distance < closestDistance:
                closestDistance = distance
                closestMuni = key

    except:
        print("GPS parsing error")

    finally:
        return(closestMuni)


#end get_munis


# Finds distance between two GPS coordinates
# Method adopted from https://janakiev.com/blog/gps-points-distance-python/
# Receives: List<float><float> municipality GPS coord, List<float><float> report GPS coord
# Returns: <int> distance between the two coordinates
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