//
//  NearEarthObjects.swift
//  NearEarthObjects
//
//  Created by Matheus Oliveira on 10/4/22.
//

import Foundation

class NearEarthObjects {
    let name: String
    let designation: String
    let isWorldKiller: Bool
    
    //Memberwise Initializer
    init(name: String, designation: String, isWorldKiller: Bool) {
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWorldKiller
    }
        //Failable initializer
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name_limited"] as? String else {return nil}
        guard let designation = dictionary["designation"] as? String else {return nil}
        guard let isWK = dictionary["is_potentially_hazardous_asteroid"] as? Bool else {return nil}
        
        self.name = name
        self.designation = designation
        self.isWorldKiller = isWK
    }
    
}// End of Class

/**
 Example of what the JSON Obj looks like
 {TLD
     "links": {
     },
     "page": {
     },
     "near_earth_objects": [
         {
             "links": {
                 "self": "http://api.nasa.gov/neo/rest/v1/neo/2000433?api_key=mseaJA1uplRc8T1f1NfkhgNv6JTklbzGoiCsZmdn"
             },
             "id": "2000433",
             "neo_reference_id": "2000433",
             "name": "433 Eros (A898 PA)",
             "name_limited": "Eros",
             "designation": "433",
             "nasa_jpl_url": "http://ssd.jpl.nasa.gov/sbdb.cgi?sstr=2000433",
             "absolute_magnitude_h": 10.31,
             "estimated_diameter": {
             },
             "is_potentially_hazardous_asteroid": false,
             "close_approach_data": [
                 {
                     },
                     "orbiting_body": "Earth"
 
 */
