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
    private var _vRights:String
    private var _vPrice:String
    private var _vImageUrl:String
    private var _vArtist:String
    private var _vVideoUrl:String
    private var _vImid:String
    private var _vGenre:String
    private var _vLinkToiTunes:String
    private var _vReleaseDate:String
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToItunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDate: String {
        return _vReleaseDate
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
        
        //Video rights
        if let rights = data["rights"] as? JSONDictionary, vRights = rights["label"] as? String {
            _vRights = vRights
        } else {
            _vRights = ""
        }
        
        //Video Price
        if let price = data["im:price"] as? JSONDictionary, vPrice = price["label"] as? String {
            _vPrice = vPrice
        } else {
            _vPrice = ""
        }
        
        //The Video Image
        if let img = data["im:image"] as? JSONArray,
            image = img[2] as? JSONDictionary,
            immage = image["label"] as? String {
                _vImageUrl = immage.stringByReplacingOccurrencesOfString("100x100", withString: "600x600")
        } else {
            _vImageUrl = ""
        }
        
        //Video Artist
        if let artist = data["im:artist"] as? JSONDictionary, vArtist = artist["label"] as? String {
            _vArtist = vArtist
        } else {
            _vArtist = ""
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
        
        //Video ID
        if let id = data["id"] as? JSONDictionary, attributes = id["attributes"] as? JSONDictionary,
            imid = attributes["im:id"] as? String {
            _vImid = imid
        } else {
            _vImid = ""
        }
        
        //Video Genre
        if let cat = data["category"] as? JSONDictionary, attributes = cat["attributes"] as? JSONDictionary,
            term = attributes["term"] as? String {
                _vGenre = term
        } else {
            _vGenre = ""
        }
        
        //Link to iTunes
        if let id = data["id"] as? JSONDictionary, label = id["label"] as? String {
            _vLinkToiTunes = label
        } else {
            _vLinkToiTunes = ""
        }
        
        //Release Date
        if let releaseDate = data["im:releaseDate"] as? JSONDictionary, attributes = releaseDate["attributes"] as? JSONDictionary,
            label = attributes["label"] as? String {
                _vReleaseDate = label
        } else {
            _vReleaseDate = ""
        }
        
    }
}