//
//  DBUserSync.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 28/12/2017.
//  Copyright © 2017 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Firebase
import UIKit

/*
 * Sync content of you from User info of the DB
 */
class DBUserSync : DBViewContentSync {
    
    private var userID : String!
    private var cRef : DatabaseReference
    public var Name : String?
    public var FavSport : String?
    public var Bio : String?
    public var Age : String?
    
    init(userID : String!) {
        self.userID = userID
        self.cRef = Database.database().reference().child("users").child(userID)
        
        super.init()
    }
    
    func getUserInformations(completionHandler: @escaping (Bool)-> ()) {
        self.cRef.queryOrdered(byChild: "name").observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            self.Name = value?["name"] as? String
            self.FavSport = value?["favoriteSport"] as? String
            self.Bio = value?["bio"] as? String
            let age = (value?["age"] as? CLong)!
            self.Age = String(age) + " yo"
            completionHandler(true)
        }) { (error) in
            print(error.localizedDescription)
            completionHandler(false)
        }
    }
    
    /* sync ImageView with photoURL of user */
    func addPictureRel(image : UIImageView) {
        cRef.child("photoURL").observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let name = snap.value as? String
            if let url = URL(string : name!) {
                image.contentMode = .scaleAspectFit
                self.downloadImage(url: url, image : image)
            }
        })
    }
    
    
}
