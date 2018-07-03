//
//  ChallengesDetailViewController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/02/2018.
//  Copyright © 2018 Simon BRAMI. All rights reserved.
//

import UIKit

class ChallengesDetailViewController: UIViewController {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var titleChallenge: UILabel!
    @IBOutlet weak var descChallenge: UILabel!
    @IBOutlet weak var dateChallenge: UILabel!
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var joinButton: UIButton!
    
    private var Dbw = DBWriter()
    
    private var IdChallenge: String?
    
    var Db = DBFeedCollection()
    override func viewDidLoad() {
        super.viewDidLoad()
        joinButton.addTarget(self, action: #selector(self.onJoinChallengeClick), for: .touchUpInside)
        self.Db.getSingleElement(id: IdChallenge!){ bool in
            self.displayDetails()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func setIdChallenge(value: String) {
        IdChallenge = value
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        
        let ti = NSInteger(interval)
        
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        let hours = (ti / 3600)
        
        return String(format: "%0.2d:%0.2d:%0.2d",hours,minutes,seconds)
    }
    
    public func displayDetails() {
        let elem = Db.getSingleElem()
        
        let sync = DBUserSync(userID : elem["creator_user"] as? String!)
        sync.addPictureRel(image : self.imageUser)
        
        // Making the circle shape of the image.
        imageUser.layer.cornerRadius = imageUser.frame.height/2
        imageUser.clipsToBounds = true
        titleChallenge.text = elem["title"] as? String
        descChallenge.text = elem["description"] as? String
        let valDate = elem["time"] as? String
        if (valDate != nil){
            dateChallenge.text = TimeConverter.timeIntervalToEngWithHour(stringInterval: valDate!)
        }
    }
    
    @objc private func onJoinChallengeClick() {
        Dbw.joinChallenge(challengeId: IdChallenge, userMessage: messageText.text){ bool in

        }
    }
}
