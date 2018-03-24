//
//  NotifDetailViewController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 24/03/2018.
//  Copyright © 2018 Simon BRAMI. All rights reserved.
//

import UIKit

class NotifDetailViewController: UIViewController {

    
    @IBOutlet weak var titleNotif: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var dateNotif: UILabel!
    @IBOutlet weak var messageNotif: UILabel!
    @IBOutlet weak var ageUser: UILabel!
    
    private var IdNotif: String?
    private var Db = DBFeedCollection()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Db.getNotifById(id: IdNotif!){ bool in
            self.displayDetails()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setIdNotif(value: String?) {
        IdNotif = value
    }
    
    public func displayDetails() {
        let elem = Db.getSingleElem()
        
        let sync = DBUserSync(userID : elem["from_id"] as? String!)
        sync.addPictureRel(image : self.imageUser)
        sync.getUserInformations(){ bool in
            self.titleNotif.text = sync.Name
            self.ageUser.text = sync.Age
            print("age :", sync.Age)
        }
        // Making the circle shape of the image.
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        imageUser.clipsToBounds = true
        messageNotif.text = elem["message"] as? String
        let valDate = elem["date"] as? String
        print(valDate)
        if (valDate != nil){
            dateNotif.text = TimeConverter.timeIntervalToEngWithHour(stringInterval: valDate!)
        }
    }

}
