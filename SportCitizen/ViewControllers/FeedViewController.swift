//
//  FeedViewController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import Firebase

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var Elements = DBFeedCollection()
    @IBOutlet weak var collectionView: UICollectionView!
    var refresher:UIRefreshControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.alwaysBounceVertical = true

        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshStream), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        loadImages()
        // Do any additional setup after loading the view.
    }

    @objc func refreshStream() {
        print("refresh")
        self.Elements.Elements.removeAll()
        self.Elements.getFeedCollection() { bool in
            self.collectionView.reloadData()
        }
        print("end")
        self.refresher.endRefreshing()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.Elements.Elements.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let elem = Elements.Elements[indexPath.row]
        let sync = DBUserSync(userID : elem["creator-user"] as! String!)
        //cell.imageView.image = image
        sync.addPictureRel(image : cell.imageView)
        cell.titleLabel.text = elem["title"] as? String
        cell.DescriptionLabel.text = elem["description"] as? String
        cell.locationLabel.text = elem["location"] as? String
        cell.idPost = elem["chall_id"] as? String

        cell.imageView.layer.cornerRadius = cell.imageView.frame.height/2
        cell.imageView.clipsToBounds = true
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: cell.frame.height - 4, width: cell.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        cell.layer.addSublayer(bottomLine)
        return cell
    }

    func loadImages(){
       self.Elements.getFeedCollection() { bool in
            self.collectionView.reloadData()
        }
    }
    
    /*
    * Sign Out function that redirects to SignIn View controller.
    */
    @IBAction func LogoutAction(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        // If the user has well signed out, show the signIn view.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Signin")
        self.present(controller, animated: true, completion: nil)
    }
}
