//
//  DBFeedCollection.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 26/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import Firebase
import Foundation

class DBFeedCollection {
    public var Title: String!
    public var Description: String!
    public var MinImage: UIImage!
    public var Location: String!
    public var Sport: String!
    private var Elements: [Dictionary<String, Any>] = [Dictionary<String, Any>]()
    private var SingleElem: Dictionary<String, Any> = Dictionary<String, Any>()
    let databaseRoot: DatabaseReference!
    let userInfo: User!
    
    init() {
        databaseRoot = Database.database().reference()
        userInfo = Auth.auth().currentUser
    }
    
    func getFeedCollection(completionHandler: @escaping (Bool)-> ()){
        let userRef = self.databaseRoot.child("challenges")

        userRef.queryOrdered(byChild: "title").observe(DataEventType.value, with: { snapshot in
            for snap in snapshot.children {
                let value = snap as! DataSnapshot
                //print("Feed List : ", value.childSnapshot(forPath: "description").value ?? "")
                var newVal : Dictionary<String, Any> = Dictionary<String, Any>()
                newVal["title"] = value.childSnapshot(forPath: "title").value ?? ""
                newVal["description"] = value.childSnapshot(forPath: "description").value ?? ""
                newVal["location"] = value.childSnapshot(forPath: "location").value ?? ""
                newVal["sport"] = value.childSnapshot(forPath: "sport").value ?? ""
                newVal["creator_user"] = value.childSnapshot(forPath: "creator_user").value ?? ""
                newVal["chall_id"] = value.childSnapshot(forPath: "chall_id").value ?? ""
                self.Elements.append(newVal)
            }
            completionHandler(true)
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    /* sync all notifications of the user */
    func syncNotificationCollection(completionHandler: @escaping (Bool)-> ()){
        let ref = self.databaseRoot.child("users").child((self.userInfo?.uid)!).child("notifications")
        
        //self.notifications.removeAll()
        ref.queryOrdered(byChild: "date").observe(DataEventType.value, with: { snapshot in
            for snap in snapshot.children {
                let value = snap as! DataSnapshot
                var newVal : Dictionary<String, Any> = Dictionary<String, Any>()
                newVal["type"] = value.childSnapshot(forPath: "type").value ?? ""
                newVal["message"] = value.childSnapshot(forPath: "message").value ?? ""
                newVal["chall_id"] = value.childSnapshot(forPath: "chall_id").value ?? ""
                newVal["from_id"] = value.childSnapshot(forPath: "from_id").value ?? ""
                newVal["date"] = value.childSnapshot(forPath: "date").value ?? ""
                newVal["notif_id"] = value.childSnapshot(forPath: "notif_id").value ?? ""
                self.Elements.append(newVal)
                //print("tab =", newVal)
            }
            print("Handler = true ")
            completionHandler(true)
        }) { (error) in
             print("Handler = false")
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    func getSingleElement(id: String, completionHandler: @escaping (Bool)-> ()) {
        let userRef = self.databaseRoot.child("challenges").child(id)
        
        userRef.queryOrdered(byChild: "title").observeSingleEvent(of: .value, with: { snapshot in
                let value = snapshot.value as? NSDictionary
                var newVal : Dictionary<String, Any> = Dictionary<String, Any>()
                newVal["title"] = value?["title"]
                newVal["description"] = value?["description"]
                newVal["location"] = value?["location"]
                newVal["sport"] = value?["sport"]
                newVal["time"] = value?["time"]
                 newVal["creator_user"] = value?["creator_user"]
                newVal["chall_id"] = value?["chall_id"]
                self.SingleElem = newVal
                completionHandler(true)
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    func getNotifById(id: String, completionHandler: @escaping (Bool)-> ()) {
        let userRef = self.databaseRoot.child("users").child((self.userInfo?.uid)!).child("notifications").child(id)
        
        userRef.queryOrdered(byChild: "date").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            var newVal : Dictionary<String, Any> = Dictionary<String, Any>()
            newVal["message"] = value?["message"]
            newVal["from_id"] = value?["from_id"]
            newVal["date"] = value?["date"]
            newVal["type"] = value?["type"]
            newVal["chall_id"] = value?["chall_id"]
            newVal["notif_id"] = value?["notif_id"]
            self.SingleElem = newVal
            completionHandler(true)
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    func getSingleElem() -> Dictionary<String, Any> {
        return SingleElem
    }
    
    func getElements() -> [Dictionary<String, Any>] {
        return Elements;
    }
    
    func removeElements() {
        Elements.removeAll();
    }
    
}
