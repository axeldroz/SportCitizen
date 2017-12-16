//
//  Sport.swift
//  SportCitizen
//
//  Created by Axel Droz on 16/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation

/* Describe sports objec */
class Sport {
    var id : Int = 0
    var name : String = ""
    var logoName : String = ""
    
    init (){
        
    }
    init(_id : Int, _name : String, _logo : String) {
        self.id = _id
        self.name = _name
        self.logoName = _logo
    }
}
