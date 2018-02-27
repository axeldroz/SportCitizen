//
//  FeedViewController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CLLocationManagerDelegate {
    var locationManager : CLLocationManager! = nil

    var Elements = DBFeedCollection()
    @IBOutlet weak var collectionView: UICollectionView!
    var refresher:UIRefreshControl!
    var targetChallenge: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // location ask
        initLocation()
        
        collectionView.alwaysBounceVertical = true
    
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.estimatedItemSize = CGSize(width: view.frame.width - 8, height: 110)
        flowLayout.sectionInset = UIEdgeInsetsMake(8, 8, 0, 0)

        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(refreshStream), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        loadImages()
        // Do any additional setup after loading the view.
    }
    
    private func initLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        print("ehhhhh OUIIII")
    }
    
    @objc func refreshStream() {
        print("refresh")
        self.Elements.removeElements()
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowDetailChallSegue"){
        if (targetChallenge != nil) {
            let DestinationController : ChallengesDetailViewController = segue.destination as! ChallengesDetailViewController
        
                DestinationController.setIdChallenge(value: targetChallenge!)
            }
        }
        
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
        
        // Creates line under each feed element.
        /*let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: cell.frame.height - 4, width: cell.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        cell.layer.addSublayer(bottomLine)*/
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tmp = Elements.getElements()
        var index: Int = 0
        for elem in tmp {
            if (index == indexPath.item){
                targetChallenge = elem["chall_id"] as? String
            }
            index += 1
        }
        performSegue(withIdentifier: "ShowDetailChallSegue", sender: self)
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
