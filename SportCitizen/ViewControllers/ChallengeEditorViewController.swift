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
import CoreLocation

class ChallengeEditorViewController: UIViewController, CLLocationManagerDelegate{
    @IBOutlet weak var titleView: UITextField!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var descrView: UITextView!
    @IBOutlet weak var datePickerText: UITextField!
    @IBOutlet weak var sportPickerText: UITextField!
    
    
    let databaseRoot = Database.database().reference()
    var dbw : DBWriter = DBWriter()
    let edi : UIDatePickerCreator = UIDatePickerCreator()
    let custPicker : UISyncDataPickerCreator = UISyncDataPickerCreator()
    let userInfo = Auth.auth().currentUser
    var photoURL : String!
    let locationManager : CLLocationManager = CLLocationManager()
    var city : String!
    var myLocation : CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotoURL()
        createButton.addTarget(self, action: #selector(self.onClickButton), for: .touchUpInside)
        edi.create(field : self.datePickerText!, view : self.view!)
        custPicker.create(field : self.sportPickerText!, view : self.view!, key : "sports", titleField : self.titleView)
        //initLocation()
        determineMyCurrentLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showHomeController(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Home") as! UITabBarController
        self.present(controller, animated: true, completion: nil)
    }
    
    /*
     * Manage, Update and get location user
     */
 /*   func initLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }*/
    
    func determineMyCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
    }
    
    /* get photoURL of user */
    func getPhotoURL() {
        
        let userRef = self.databaseRoot.child("users").child((userInfo?.uid)!)
        
        userRef.child("photoURL").observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let value = snap.value as? String
            self.photoURL = value
        })
    }
    
    /* event button create click func */
    @objc private func onClickButton() {
        if (photoURL == nil) {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(100), execute: {
                self.onClickButton()
            })
        }
        else {
            let values = ["sport" : custPicker.getValue()!, "title" : titleView.text!,
                      "description" : descrView.text!, "time" : edi.getValue()!,
                      "location" : "Bordeaux", "creator-user" : dbw.getUserId()!, "photoURL" : photoURL!,
                      "city" : "ok"]
        
            dbw.postWithId(key: "challenges", values: values)
                self.showHomeController()
            
        }
    }

}
