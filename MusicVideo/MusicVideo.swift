//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 09/06/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import Foundation

class Videos {
    
    //Data encapsulation
    
    private var _vName:String
    private var _vRights:String     //TODO
    private var _vPrice:String      //TODO
    private var _vImageUrl:String
    private var _vArtist:String     //TODO
    private var _vVideoUrl:String
    private var _vImid:String       //TODO
    private var _vGenre:String      //TODO
    private var _vLinkToiTunes:String    //TODO
    private var _vReleaseDate:String    //TODO
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    init(data: JSONDictionary) {
        
        //If we do not initialize akk properties we will get an error message
        //Return from initalizer without initalizing all stored properties
        
        //Video name 
        if let name = data["im:name"] as? JSONDictionary, vName = name["label"] as? String {
            self._vName = vName
        } else {
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            _vName = ""
        }
        
        //The Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        //Video URL
        if let video = data["link"] as? JSONArray,
            vUrl = video[1] as? JSONDictionary,
            vHref = vUrl["attributes"] as? JSONDictionary,
            vVideoUrl = vHref["href"] as? String {
                self._vVideoUrl = vVideoUrl
        } else {
            _vVideoUrl = ""
        }
        
    }
}