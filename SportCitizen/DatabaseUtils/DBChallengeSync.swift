//
//  DBChallengeViewSync.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 28/12/2017.
//  Copyright © 2017 Axel Drozdzynski. All rights reserved.
//

import Foundation
import Firebase
import UIKit

/*
 * Sync content of you from Challenge info of the DB
 */
class DBChallengeSync : DBViewContentSync {
    
    private var challengeID : String!
    private var cRef : DatabaseReference
    
    init(challengeID : String!) {
        self.challengeID = challengeID
        self.cRef = Database.database().reference().child("challenges").child(challengeID)
        super.init()
    }
    /* sync ImageView with photoURL of challenge */
    func addPicRel(image : UIImageView) {
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
