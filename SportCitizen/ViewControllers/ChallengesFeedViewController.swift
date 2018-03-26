//
//  ChallengesFeedViewController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 26/03/2018.
//  Copyright © 2018 Simon BRAMI. All rights reserved.
//

import UIKit

class ChallengesFeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var Elements = DBFeedCollection()
    var refresher:UIRefreshControl!
    var targetChallenge: String?
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        Elements.getMyChallengesCollection(){bool in
            
        }
        collectionView.alwaysBounceVertical = true
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 16, height: 110)
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
        flowLayout.minimumLineSpacing = 6
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshStream), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }

    
    @objc func refreshStream() {
        print("refresh")
        self.Elements.removeElements()
        self.Elements.getMyChallengesCollection() { bool in
            self.collectionView.reloadData()
        }
        print("end refreshing")
        self.refresher.endRefreshing()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Elements.getElements().count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        let elem = Elements.getElements()[indexPath.row]
        let sync = DBUserSync(userID : elem["creator_user"] as? String!)
        //cell.imageView.image = image
        sync.addPictureRel(image : cell.imageView)
        cell.titleLabel.text = elem["title"] as? String
        cell.DescriptionLabel.text = elem["description"] as? String
        cell.locationLabel.text = elem["location"] as? String
        cell.idPost = elem["chall_id"] as? String
        
        // Making the circle shape of the image.
        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.imageView.clipsToBounds = true
        
        //cell.backgroundColor = UIColor(hex: "fff5e6")
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 4
        cell.layer.borderColor = UIColor.lightGray.cgColor
        
        
        cell.imageView.layer.shadowColor = UIColor.lightGray.cgColor;
        cell.imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cell.imageView.layer.shadowRadius = 2
        cell.imageView.layer.shadowOpacity = 1
        
        return cell
    }

    

}
