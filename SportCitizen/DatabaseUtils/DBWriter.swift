//
//  DBWriter.swift
//  SportCitizen
//
//  Created by Axel Droz on 22/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation
import Firebase

/*
 * Fill / Update the firebase db
 */
class DBWriter {
    let databaseRoot = Database.database().reference()
    
    init() {
        
    }
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func editUserInfo(values : [String : String]){
        let userRef = databaseRoot.child("users").child((getUserId())!)
        
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err.debugDescription)
                return
            }
        })
    }
    
    func editFieldInfo(key : String, values : [String : String]) {
        let ref = databaseRoot.child(key)
        
        ref.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err.debugDescription)
                return
            }
        })
    }
    
    /* fill data with ID */
    func postWithId(key : String, values : [String : String]) {
        let ref = databaseRoot.child(key).childByAutoId()
        
        ref.setValue(values)
        let id = ref.key
        databaseRoot.child(key).child(id).updateChildValues(["chall_id": id])
    }
    

    
}
