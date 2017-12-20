//
//  ProfileController.swift
//  SportCitizen
//
//  Created by Axel DROZDZYNSKI on 13/12/2017.
//  Copyright © 2017 Axel DROZDZYNSKI. All rights reserved.
//

import UIKit
import Firebase

class ProfileController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioDescr: UITextView!
    @IBOutlet weak var favoriteSport: UIPickerView!
    
    var sports : [String] = ["loading ..."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     * following functions manage pickerview
     */
    func getPickerData() {
        let databaseRoot = Database.database().reference()
        let sportsRef = databaseRoot.child("sports")
        
        sportsRef.observeSingleEvent(of: .value, with: { snapshot in
            var i : Int = 1
            self.sports.removeAll()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let name = snap.value as! String
                print("new sport : ", name)
                self.sports.append(name)
                i += 1
                
            }
            self.favoriteSport.reloadAllComponents()
        })

    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sports[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    

}
