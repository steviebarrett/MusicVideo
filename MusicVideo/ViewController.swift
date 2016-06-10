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
    
    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.reachabilityStatusChanged), name: "ReachStatusChanged", object: nil)
        
        reachabilityStatusChanged()
        
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
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS : view.backgroundColor = UIColor.redColor()
            displayLabel.text = "No Internet"
        case WIFI : view.backgroundColor = UIColor.greenColor()
            displayLabel.text = "Reachable with WiFi"
        case WWAN : view.backgroundColor = UIColor.yellowColor()
            displayLabel.text = "Reachable with Cellular"
        default: return
        }
    }
    
    //Is called just as the object is about to be deallocated
    deinit {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
    }
    
}

