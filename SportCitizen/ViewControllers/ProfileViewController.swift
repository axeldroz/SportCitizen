//
//  ProfileViewController.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 20/12/2017.
//  Copyright © 2017 Axel Drozdzynski. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var favSportView: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var bioView: UITextView!

    var name : String = "Loading"
    var sync : DBViewContentSync = DBViewContentSync()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sync.addUserRel(label : nameView, key : "name")
        sync.addUserRel(image: pictureView, key: "photoURL")
        sync.addUserRel(label : favSportView, key : "favoriteSport")
        sync.addUserRel(text: bioView, key : "bio")
        sync.addUserRel(label: ageLabel, key: "age")
        
        pictureView.layer.cornerRadius = pictureView.frame.height/2
        pictureView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
