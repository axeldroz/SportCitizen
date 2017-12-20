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
    var sports = [String]()
    let databaseRoot = Database.database().reference()
    
    init(){
        self.sports = getData()
    }
    
    /* get sports list from Firebase Database */
    func getData() -> [String] {
        var list : [String] = []
        let sportsRef = databaseRoot.child("sports")
        
        sportsRef.observeSingleEvent(of: .value, with: { snapshot in
            var i : Int = 1
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let name = snap.value as! String
                print("new sport : ", name)
                list.append(name)
                i += 1
            } })
        print("listCount = ", list.count)
        return list
    }
    
    /*func toStringList() -> [String] {
        print("ToString")
        var list : [String] = ["hello", "hello"]
        for s in self.sports {
            list.append(s.toString())
            print("name = " + s.toString())
        }
        return list
    }*/
    
    func getList() -> [String] {
        return sports
    }
}
