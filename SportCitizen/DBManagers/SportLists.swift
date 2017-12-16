//
//  SportLists.swift
//  SportCitizen
//
//  Created by Axel Droz on 16/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation
import Firebase

/* sport list which describ sports */
class SportList {
    var sports = [Sport]()
    let databaseRoot = Database.database().reference()
    
    init(){
        self.sports = getData()
    }
    
    /* get sports list from Firebase Database */
    func getData() -> [Sport] {
        var list = [Sport]()
        let sportsRef = databaseRoot.child("sports")
        
        sportsRef.observeSingleEvent(of: .value, with: { snapshot in
            var i : Int = 1
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let name = snap.value as! String
                list.append((Sport(_id : i, _name : name, _logo : "")))
                i += 1
            } })
        return list
    }
}
