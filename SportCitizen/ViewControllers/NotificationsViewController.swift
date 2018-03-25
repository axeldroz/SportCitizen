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
    
    var refresher:UIRefreshControl!

    var Elements : DBFeedCollection = DBFeedCollection()
    var targetNotif: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.Elements.removeElements()
        self.Elements.syncNotificationCollection() { bool in
            self.collectionViewNot.reloadData()
        }
        
        // Refresher
        self.refresher = UIRefreshControl()
        self.collectionViewNot!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshStream), for: .valueChanged)
        self.collectionViewNot!.addSubview(refresher)

        let flowLayout = collectionViewNot.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 16, height: 57)
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        flowLayout.minimumLineSpacing = 6
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // RefreshControl function
    @objc func refreshStream() {
        print("refresh")
        self.Elements.removeElements()
        self.Elements.syncNotificationCollection() { bool in
            self.collectionViewNot.reloadData()
        }
        print("end")
        self.refresher.endRefreshing()
        
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
        let sync = DBUserSync(userID : elem["from_id"] as! String!)
        sync.getUserInformations(){ Bool in
            cell.titleLabel.text = sync.Name
        }
            
        //cell.imageView.image = image
        sync.addPictureRel(image: cell.imageView)
        switch(elem["type"] as? String){
        case "joinchall"?:
            cell.DescriptionLabel.text = "Wants to join your challenge!"
            break
        case "challaccept"?:
            cell.DescriptionLabel.text = "Accepted your challenge request!"
            break
        case "challdecline"?:
            cell.DescriptionLabel.text = "Declined your challenge request!"
            break
        default:
            cell.DescriptionLabel.text = ""
            break
        }
        //cell.DescriptionLabel.text = elem["message"] as? String
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
