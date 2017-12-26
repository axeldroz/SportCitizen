//
//  UISyncDataPickerCreator.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 26/12/2017.
//  Copyright © 2017 Axel Drozdzynski. All rights reserved.
//

import Foundation
import UIKit
import Firebase

/*
 * UIDatePickerCreator
 * Goal : display a data picker which is synchronized with Firebase Database
 */
class UISyncDataPickerCreator : NSObject, UIPickerViewDataSource, UIPickerViewDelegate{
    let databaseRoot = Database.database().reference()
    let pickerView = UIPickerView()
    var pickerText : UITextField!
    var view : UIView!
    var sports : [String] = ["loading ..."]
    var sportSelected : String = "undefined"
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    /* creation of picker view display */
    func create(field : UITextField!, view : UIView!) {
        self.pickerText = field
        self.view = view
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed1))
        pickerView.delegate = self
        pickerView.dataSource = self
        getPickerData()
        toolbar.setItems([doneButton], animated: false)
        toolbar.sizeToFit()
        self.pickerText.inputAccessoryView = toolbar
        self.pickerText.inputView = self.pickerView
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
    
    @objc func donePressed1 () {
        self.pickerText.text = sportSelected
        print ("it's finally ok2")
        self.view.endEditing(true)
    }
}
