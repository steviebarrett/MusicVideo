//
//  APIManager.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 09/06/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import Foundation

class APIManager {
    
    func loadData(urlString:String, completion: (result:String) -> ()) {
        
        let config = NSURLSessionConfiguration.ephemeralSessionConfiguration()
        
        let session = NSURLSession(configuration: config)
//        let session = NSURLSession.sharedSession()
        let url = NSURL(string: urlString)!
        
        let task = session.dataTaskWithURL(url) {
            (data, response, error) -> Void in
            
            dispatch_async(dispatch_get_main_queue()) {
                if error != nil {
                    completion(result: (error!.localizedDescription))
                } else {
                    completion(result: "NSURLSession successful")
                    print(data)
                }
            }
        }
        task.resume()
    }
}