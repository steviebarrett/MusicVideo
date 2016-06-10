//
//  APIManager.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 09/06/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: [Videos] -> Void) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                
                //Added for JSONSerialization
//                print(data)
                do {
                    /* .AllowFragments - top level object is not Array or Dictionary.
                    Any type of string or value
                    NSJSONSerialization requires to Do / Try / Catch
                    Converts the NSDATA into a JSON Object and cast it to a Dictionary */
                    
                    if let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? JSONDictionary,
                        feed = json["feed"] as? JSONDictionary,
                        entries = feed["entry"] as? JSONArray {
                        
                        var videos = [Videos]()
                        for entry in entries {
                            let entry = Videos(data: entry as! JSONDictionary)
                            videos.append(entry)
                        }
                        
                        let i = videos.count
                        print("iTunesApiManager - total count --> \(i)")
                        print(" ")
                        
                        let priority = DISPATCH_QUEUE_PRIORITY_HIGH
                        dispatch_async(dispatch_get_global_queue(priority, 0)) {
                            dispatch_async(dispatch_get_main_queue()) {
                                completion(videos)
                            }
                        }
                    }
                } catch {
                    print("Error in NSJSONSerialization")
                }
                //End of JSONSerialization
            }
        }
        task.resume()
    }
}