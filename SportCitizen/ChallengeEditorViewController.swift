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

class ChallengeEditorViewController: UIViewController {
   
    @IBOutlet weak var sportPickerView: UIPickerView!
    @IBOutlet weak var datePickerView: UIDatePicker!
    @IBOutlet weak var titleView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
