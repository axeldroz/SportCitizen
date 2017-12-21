//
//  ProfileViewController.swift
//  SportCitizen
//
//  Created by Axel Droz on 20/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var favSportView: UILabel!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    @IBOutlet weak var bioView: UITextView!

    var name : String = "Loading"
    var sync : DBContentSync = DBContentSync()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        sync.addUserRel(label : nameView, key : "name")
        sync.addUserRel(image: pictureView, key: "photoURL")
        sync.addUserRel(label : favSportView, key : "favoriteSport")
        sync.addUserRel(text: bioView, key : "bio")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
