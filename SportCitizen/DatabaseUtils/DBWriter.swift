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
    private var cRef : DatabaseReference?
    private var nRef : DatabaseReference?
    
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
    
    func joinChallenge(challengeId: String!, userMessage: String!, completionHandler: @escaping (Bool)-> ()){
        self.cRef = Database.database().reference().child("challenges").child(challengeId)
        self.nRef = Database.database().reference().child("users")
        
        var userTarget: String?
        var values: [String : String] = [String : String]()
        cRef?.queryOrdered(byChild: "title").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            userTarget = value?["creator_user"] as? String
            
            // Bind values of notification
            values = ["chall_id" : challengeId, "message": userMessage, "type": "joinchall", "from_id": self.getUserId()!, "date": String(NSDate().timeIntervalSince1970)]
            let ref = self.nRef?.child(userTarget!).child("notifications").childByAutoId()
            ref?.setValue(values)
            let id = ref?.key
            self.nRef?.child(userTarget!).child("notifications").child(id!).updateChildValues(["notif_id": id!])
            completionHandler(true)
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    func answerChallenge(challengeId: String!, codeAnswer: Int, completionHandler: @escaping (Bool)-> ()) {
        self.cRef = Database.database().reference().child("challenges").child(challengeId)
        self.nRef = Database.database().reference().child("users")
        var userMessage: String?
        var typeNotif: String?
        let sync = DBUserSync(userID : getUserId())
        
        // Get user informations first
        sync.getUserInformations(){bool in
            
            // Set message to send
            switch(codeAnswer){
            case 1:
                userMessage = sync.Name! + " accepted you in his challenge!"
                typeNotif = "challaccept"
                break
            case 2:
                userMessage = sync.Name! + " declined your apply. Sorry!"
                typeNotif = "challdecline"
                break
            default:
                break
            }
            
            var userTarget: String?
            var values: [String : String] = [String : String]()
            self.cRef?.queryOrdered(byChild: "title").observeSingleEvent(of: .value, with: { snapshot in
                let value = snapshot.value as? NSDictionary
                userTarget = value?["creator_user"] as? String
                
                // Bind values of notification
                values = ["chall_id" : challengeId, "message": userMessage!, "type": typeNotif!, "from_id": self.getUserId()!, "date": String(NSDate().timeIntervalSince1970)]
                let ref = self.nRef?.child(userTarget!).child("notifications").childByAutoId()
                ref?.setValue(values)
                let id = ref?.key
                self.nRef?.child(userTarget!).child("notifications").child(id!).updateChildValues(["notif_id": id!])
                completionHandler(true)
            }) { (error) in
                print(error.localizedDescription)
                completionHandler(false)
            }
        }
        
    }
    
}
