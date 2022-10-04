//
//  NearEarthObjectController.swift
//  NearEarthObjects
//
//  Created by Matheus Oliveira on 10/4/22.
//

import Foundation

class NearEarthObjectController {
    
    private static let baseURLString = "https://api.nasa.gov/neo/rest/v1/"
    
    //keys
    private static let kNeoComponent = "neo"
    private static let kBrowseComponent = "browse"
    private static let kApiKeyKey = "api_key"
    private static let kApiKeyValue = "mseaJA1uplRc8T1f1NfkhgNv6JTklbzGoiCsZmdn"
    
    //MARK: - CRUD
    static func fetchNeos(completionHandler: @escaping ([NearEarthObjects]?) -> Void) {
        //Step 1: Create URL
        guard let baseUrl = URL(string: baseURLString) else {completionHandler(nil); return}
        let neoURL = baseUrl.appendingPathComponent(kNeoComponent)
        let browseURL = neoURL.appendingPathComponent(kBrowseComponent)
        
        //To use URL query items you need a URLComponent struct
        var urlComponents = URLComponents(url: browseURL, resolvingAgainstBaseURL: true)
        //Step 1.2 Create query items
        let apiQueryItems = URLQueryItem(name: kApiKeyKey, value: kApiKeyValue)
        urlComponents?.queryItems = [apiQueryItems]
        
        guard let finalURL = urlComponents?.url else {completionHandler(nil); return}
        print(finalURL)
        //Step 2: Start a dataTask to retrieve that data
        
        URLSession.shared.dataTask(with: finalURL) { neoData, _, error in
            //Handle the error
            if let error = error {
                print("There was an error with the data task", error.localizedDescription)
                completionHandler(nil)
            }
            //check for data
            guard let data = neoData else {completionHandler(nil); return}
            // Now that we have data I can convert that data to a JSON object
            do {
                guard let topLevelDictionary = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String: Any],
                      let neoArray = topLevelDictionary["near_earth_objects"] as? [[String: Any]] else {completionHandler(nil); return}
                //Create a temporary array to hold on to these neos
                var tempNeoArray: [NearEarthObjects] = []
                
                for neoDict in neoArray {
                    guard let neo = NearEarthObjects(dictionary: neoDict) else {completionHandler(nil); return}
                    tempNeoArray.append(neo)
                }
                completionHandler(tempNeoArray)
            }
        }.resume()
    }

}//End of Class
