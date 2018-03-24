//
//  NotificationsViewController.swift
//  SportCitizen
//
//  Created by Axel Droz on 28/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class NotificationsViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    

    @IBOutlet weak var collectionViewNot: UICollectionView!
    
    var Elements : DBFeedCollection = DBFeedCollection()
    var targetNotif: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Elements.removeElements()
        self.Elements.syncNotificationCollection() { bool in
            self.collectionViewNot.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetailNotifSegue"){
            if (targetNotif != nil) {
                let DestinationController : NotifDetailViewController = segue.destination as! NotifDetailViewController
                
                DestinationController.setIdNotif(value: targetNotif!)
                print("ID BIEN SET ")
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Elements.getElements().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let elem = self.Elements.getElements()[indexPath.row]
        print(elem["chall_id"] as! String!)
        print(elem["type"] as! String!)
        print(elem["from_id"] as! String!)

        let sync = DBUserSync(userID : elem["from_id"] as! String!)
        //cell.imageView.image = image
        sync.addPictureRel(image: cell.imageView)
        cell.titleLabel.text = elem["message"] as? String
        cell.DescriptionLabel.text = elem["message"] as? String
        cell.idPost = elem["chall_id"] as? String

        //cell.locationLabel.text = elem["location"] as? String
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tmp = Elements.getElements()
        var index: Int = 0
        for elem in tmp {
            if (index == indexPath.item){
                targetNotif = elem["notif_id"] as? String
            }
            index += 1
        }
        print("Before SEGUE NOTIF")
        performSegue(withIdentifier: "ShowDetailNotifSegue", sender: self)
    }
    
    
}
