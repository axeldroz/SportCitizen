//
//  SportLists.swift
//  SportCitizen
//
//  Created by Axel Droz on 16/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation

/* sport list which describ sports */
class SportList {
    var sports = [Sport]()
    
    init(){
        self.sports = getListOfSport()
    }
    
    /* get sports list from Firebase Database */
    func getListOfSport() -> [Sport] {
        var list = [Sport]()
        
        list.append(Sport()) // instanciate object Sport and append into list
        return list
    }
}
