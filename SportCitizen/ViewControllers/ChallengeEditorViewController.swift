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
    
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var sports : [String] = ["loading ..."]
    var favSport : String = "undefined"
    let databaseRoot = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
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
        favSport = sports[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

}
