//
//  UIDatePickerCreator.swift
//  SportCitizen
//
//  Created by Axel Drozdzynski on 26/12/2017.
//  Copyright © 2017 Axel Drozdzynski All rights reserved.
//

import Foundation
import UIKit

/*
 * UIDatePickerCreator
 * Goal : display a date picker related with DateTextField
 */
class UIDatePickerCreator {
    
    let datePicker = UIDatePicker()
    var datePickerText: UITextField!
    var view : UIView!
    var selectedValue : String!
    
    init () {
    }
    
    func getValue() -> String! {
        return selectedValue
    }
    
    /* create the datePickjer */
    func create(field : UITextField!, view : UIView!) {
        self.datePickerText = field
        self.view = view
        
        let toolbar = UIToolbar()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.donePressed1))
        
        toolbar.setItems([doneButton], animated: false)
        toolbar.sizeToFit()
        self.datePickerText.inputAccessoryView = toolbar
        self.datePickerText.inputView = self.datePicker
    }
    
    @objc func donePressed1 () {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "EEEE MM-dd hh:mm a"
        
        self.datePickerText.text = dateFormatter.string(from: self.datePicker.date)
        dateFormatter.dateFormat = "EEEE MM-dd hh:mm a"
        selectedValue = String(datePicker.date.timeIntervalSince1970)
        print ("it's finally ok")
        self.view.endEditing(true)
    }
    
}
