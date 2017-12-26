//
//  ChallengeEditorViewController.swift
//  SportCitizen
//
//  Created by Axel Droz on 21/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
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
    let datePicker = UIDatePicker()
    var dbw : DBWriter = DBWriter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
        createButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
        createDatePicker()
        
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
    
    /*
     * Following fct to create and manage DatePicker
     */
    func createDatePicker() {
        
        datePicker.datePickerMode = .date
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        datePickerText.inputAccessoryView = toolbar
        
        datePickerText.inputView = datePicker
    }
    
    @objc func donePressed () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        
        datePickerText.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    
    /* event button create click func */
    @objc private func onClickButton() {
        let values = ["sport" : sportSelected, "title" : titleView.text!, "description" : descrView.text!]
        
        dbw.editFieldInfo(key: "challenges", values: values)
    }

}
