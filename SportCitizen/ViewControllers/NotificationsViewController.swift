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
    
    var feedco : DBFeedCollection = DBFeedCollection()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.feedco.Elements.removeAll()
        self.feedco.syncNotificationCollection() { bool in
            self.collectionViewNot.reloadData()
        }
        //loadImages()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.feedco.Elements.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let elem = self.feedco.Elements[indexPath.row]
        let sync = DBUserSync(userID : elem["from_id"] as! String!)
        //cell.imageView.image = image
        sync.addPictureRel(image: cell.imageView)
        cell.titleLabel.text = elem["message"] as? String
        cell.DescriptionLabel.text = elem["message"] as? String
        //cell.locationLabel.text = elem["location"] as? String
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.imageView.clipsToBounds = true
        
        return cell
    }
    
    
}
