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
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var ageUser: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var remindButton: UIButton!
    
    private var IdNotif: String?
    private var Db = DBFeedCollection()
    private var DbWriter = DBWriter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.Db.getNotifById(id: IdNotif!){ bool in
            self.displayDetails()
            let elem = self.Db.getSingleElem()
            if (elem["type"] as? String != "joinchall"){
                self.acceptButton.isHidden = true
                self.declineButton.isHidden = true
                self.remindButton.isHidden = true
                print(elem["type"])
            }
            if (elem["type"] as? String == "joinchall"){
                self.acceptButton.isHidden = false
                self.declineButton.isHidden = false
                self.remindButton.isHidden = false
                print(elem["type"])
            }
        }
        
        acceptButton.addTarget(self, action: #selector(self.onAcceptClick), for: .touchUpInside)
        declineButton.addTarget(self, action: #selector(self.onDeclineClick), for: .touchUpInside)
        remindButton.addTarget(self, action: #selector(self.onRemindClick), for: .touchUpInside)
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
            self.userBio.text = sync.Bio
        }
        // Making the circle shape of the image.
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        imageUser.clipsToBounds = true
        messageNotif.text = elem["message"] as? String
        let valDate = elem["date"] as? String
        if (valDate != nil){
            dateNotif.text = TimeConverter.timeIntervalToEngWithHour(stringInterval: valDate!)
        }
    }
    
    
    // Handlers for onClick events
    @objc private func onAcceptClick() {
        Db.getNotifById(id: IdNotif!){bool in
            let elem = self.Db.getSingleElem()
            self.DbWriter.answerChallenge(idNotif: self.IdNotif, challengeId: elem["chall_id"] as? String, codeAnswer: 1){ bool in
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    @objc private func onDeclineClick() {
        Db.getNotifById(id: IdNotif!){bool in
            let elem = self.Db.getSingleElem()
            self.DbWriter.answerChallenge(idNotif: self.IdNotif, challengeId: elem["chall_id"] as? String, codeAnswer: 2){ bool in
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    @objc private func onRemindClick() {
        
    }
}
