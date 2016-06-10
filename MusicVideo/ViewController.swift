//
//  ViewController.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 09/06/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Call API
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json", completion: didLoadData)
    }

    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        for (index, item) in videos.enumerate() {
            print("\(index): name = \(item.vName)")
        }
    }
    
}

