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

class ChallengeEditorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var descrView: UITextView!
    @IBOutlet weak var datePickerText: UITextField!
    
    var sports : [String] = ["loading ..."]
    var sportSelected : String = "undefined"
    let databaseRoot = Database.database().reference()
    var dbw : DBWriter = DBWriter()
    let edi : UIDatePickerCreator = UIDatePickerCreator()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
        createButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
        edi.create(field : self.datePickerText!, view : self.view!)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * Following functions get data from firebase and update content of the view
     */
    func getPickerData() {
        let sportsRef = databaseRoot.child("sports")
        
        sportsRef.observe(DataEventType.value, with: { snapshot in
            self.sports.removeAll()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let name = snap.value as! String
                self.sports.append(name)
            }
            self.pickerView.reloadAllComponents()
        })
        
    }
    
    /*
     * following functions manage pickerview
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sports[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sportSelected = sports[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    /* event button create click func */
    @objc private func onClickButton() {
        let values = ["sport" : sportSelected, "title" : titleView.text!, "description" : descrView.text!]
        
        dbw.editFieldInfo(key: "challenges", values: values)
    }

}
