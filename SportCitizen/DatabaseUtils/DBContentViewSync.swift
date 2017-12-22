//
//  DBContentUpdater.swift
//  SportCitizen
//
//  Created by Axel Droz on 21/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/*
 * Goal : Synchronise view element with database
 * Example :    var sync : DBContentSync = DBContentSync()
                sync.addUserRel(label : nameView, key : "name")
 */
class DBViewContentSync {
    let databaseRoot = Database.database().reference()
    let userInfo = Auth.auth().currentUser
    
    init () {
    }
    
    func addUserRel(label : UILabel, key : String){
        let userRef = self.databaseRoot.child("users").child((userInfo?.uid)!)
        
        userRef.child(key).observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let value = snap.value as! String
            print("NEW key : ", value)
            label.text = value
        })
    }
    
    func addUserRel(text : UITextView, key : String){
        let userRef = self.databaseRoot.child("users").child((userInfo?.uid)!)
        
        userRef.child(key).observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let value = snap.value as! String
            print("NEW key : ", value)
            text.text = value
        })
    }
    
    func addUserRel(image : UIImageView, key : String) {
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        print("UpdateName")
        userRef.child(key).observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let name = snap.value as! String
            print("NEW key : ", name)
            if let url = URL(string : name) {
                image.contentMode = .scaleAspectFit
                self.downloadImage(url: url, image : image)
            }
        })
    }
    
    /* download picture */
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL, image : UIImageView) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                image.image = UIImage(data: data)
            }
        }
    }

    
    
}
