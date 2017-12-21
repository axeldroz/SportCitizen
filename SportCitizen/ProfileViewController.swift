//
//  ProfileViewController.swift
//  SportCitizen
//
//  Created by Axel Droz on 20/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var favSportView: UILabel!
    @IBOutlet weak var refreshBarButton: UIBarButtonItem!
    
    var uid : String?
    let databaseRoot =
        Database.database().reference()
    var name : String = "Loading"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateName()
        updatePicture()
        updateFavoriteSport()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* get the name in database and update it */
    func updateName() {
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        print("UpdateName")
        userRef.child("name").observe(DataEventType.value, with: { snapshot in
          
                let snap = snapshot
                let name = snap.value as! String
                print("NEW key : ", name)
                self.nameView.text = name
            })
    }
    
    /* get the name in database and update it */
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.pictureView.image = UIImage(data: data)
            }
        }
    }
    func updatePicture() {
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        print("UpdateName")
        userRef.child("photoURL").observe(DataEventType.value, with: { snapshot in
            let snap = snapshot
            let name = snap.value as! String
            print("NEW key : ", name)
            if let url = URL(string: name) {
                self.pictureView.contentMode = .scaleAspectFit
                self.downloadImage(url: url)
            }
        })
    }
    
    /* get favorite sport data from firebase */
    func updateFavoriteSport() {
        let userInfo = Auth.auth().currentUser
        let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
        print("UpdateName")
        userRef.child("favoriteSport").observe(DataEventType.value, with: { snapshot in
            
            let snap = snapshot
            let sportValue = snap.value as! String
            print("NEW value : ", sportValue)
            self.favSportView.text = sportValue
        })
    }
    
    @objc private func onClickRefresh() {
        updateName()
        updatePicture()
        updateFavoriteSport()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
