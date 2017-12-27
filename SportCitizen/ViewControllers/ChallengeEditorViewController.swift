//
//  ChallengeEditorViewController.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 21/12/2017.
//  Copyright © 2017 Axel Drozdzynski. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ChallengeEditorViewController: UIViewController {
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var descrView: UITextView!
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var sportPickerText: UITextField!
    
    
    let databaseRoot = Database.database().reference()
    var dbw : DBWriter = DBWriter()
    let edi : UIDatePickerCreator = UIDatePickerCreator()
    let custPicker : UISyncDataPickerCreator = UISyncDataPickerCreator()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //getPickerData()
        createButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
        edi.create(field : self.datePickerText!, view : self.view!)
        custPicker.create(field : self.sportPickerText!, view : self.view!, key : "sports")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /* event button create click func */
    @objc private func onClickButton() {
        let values = ["sport" : custPicker.getValue()!, "title" : titleView.text!,
                      "description" : descrView.text!, "time" : edi.getValue()!,
                      "location" : "Bordeaux", "creator-user" : dbw.getUserId()!]
        
        dbw.postWithId(key: "challenges", values: values)
    }

}
