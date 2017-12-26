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
    var values : [String] = ["loading ..."]
    var valueSelected : String = "undefined"
    
    func getUserId() -> String? {
        return Auth.auth().currentUser?.uid
    }
    
    func getValue() -> String? {
        return valueSelected
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
            self.values.removeAll()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let name = snap.value as! String
                self.values.append(name)
            }
            self.pickerView.reloadAllComponents()
        })
        
    }
    
    /*
     * following functions manage pickerview
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return values[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        valueSelected = values[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    @objc func donePressed1 () {
        self.pickerText.text = valueSelected
        print ("it's finally ok2")
        self.view.endEditing(true)
    }
}
