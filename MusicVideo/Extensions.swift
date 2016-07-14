//
//  Extensions.swift
//  MusicVideo
//
//  Created by Stephen Barrett on 14/07/2016.
//  Copyright © 2016 Stephen Barrett. All rights reserved.
//

import UIKit

extension MusicVideoTVC: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        searchController.searchBar.text!.lowercaseString
        filterSearch(searchController.searchBar.text!)
    }
}

