//
//  ProfileController.swift
//  SportCitizen
//
//  Created by Axel DROZDZYNSKI on 13/12/2017.
//  Copyright © 2017 Axel DROZDZYNSKI. All rights reserved.
//

import UIKit
import Firebase

class EditProfileController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var bioDescr: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bioField: UITextView!

    @IBOutlet weak var favSportPicker: UITextField!
    
    let databaseRoot = Database.database().reference()
    var sync : DBViewContentSync = DBViewContentSync()
    var dbw : DBWriter = DBWriter()
    let custPicker : UISyncDataPickerCreator = UISyncDataPickerCreator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sync.addUserRel(text: bioField, key: "bio")
        saveButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
        custPicker.create(field : self.favSportPicker!, view : self.view!, key : "sports")
        custPicker.syncWithUser(key: "favoriteSport")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* event Click func */
    @objc private func onClickButton() {
        let values = ["favoriteSport" : custPicker.getValue()!, "bio" : bioField.text!]
        
        dbw.editUserInfo(values: values)
    }
}
