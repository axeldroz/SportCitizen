//
//  ProfileController.swift
//  SportCitizen
//
//  Created by Axel DROZDZYNSKI on 13/12/2017.
//  Copyright © 2017 Axel DROZDZYNSKI. All rights reserved.
//

import UIKit
import Firebase

class EditProfileController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioDescr: UITextView!
    @IBOutlet weak var favoriteSport: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var bioField: UITextView!
    
    var sports : [String] = ["loading ..."]
    var favSport : String = "undefined"
    let databaseRoot = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPickerData()
        getDataBio()
        // Do any additional setup after loading the view.
        saveButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
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
                print("new sport : ", name)
                self.sports.append(name)
            }
            self.favoriteSport.reloadAllComponents()
        })

    }
    func getDataBio() {
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        print("UpdateName")
        userRef.child("bio").observe(DataEventType.value, with: { snapshot in
            
            let snap = snapshot
            let value = snap.value as! String
            print("NEW value : ", value)
            self.bioField.text = value
        })
    }
    
    /*
     * following functions manage pickerview
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sports[row]
    }
    
    /*
     * following functions manage pickerview
     */
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sports.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        favSport = sports[row]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    /* event Click func */
    @objc private func onClickButton() {
        print ("onClickButton")
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        let values = ["favoriteSport" : favSport, "bio" : bioField.text!]
        
        userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
            if err != nil {
                print(err.debugDescription)
                return
            }
        })
    }
}
