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

    var images = [UIImage]()
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImages()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ImageCollectionViewCell
        
        let image = images[indexPath.row]
        cell.imageView.image = image
        
        return cell
    }

    func loadImages(){
        images.append(UIImage(named: "menu")!)
        images.append(UIImage(named: "menu")!)
        images.append(UIImage(named: "menu")!)
        images.append(UIImage(named: "menu")!)
        images.append(UIImage(named: "menu")!)
        self.collectionView.reloadData()
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
