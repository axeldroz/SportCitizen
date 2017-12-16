//
//  ProfileController.swift
//  SportCitizen
//
//  Created by Axel DROZDZYNSKI on 13/12/2017.
//  Copyright © 2017 Axel DROZDZYNSKI. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var bioDescr: UITextView!
    @IBOutlet weak var favoriteSport: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
