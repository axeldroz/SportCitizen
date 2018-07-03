//
//  LoginController.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 11/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class LoginController: UIViewController {
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(facebookLoginButton)
        facebookLoginButton.addTarget(self, action: #selector(customFacebookLogin), for: .touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showHomeController(){
        // If the user has well signed in, show the Home View.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Home") as! UITabBarController
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func customFacebookLogin(sender: UIButton!) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, error) in
            if error != nil {
                print("Custom login failed: ", error.debugDescription)
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            print(credential)
            Auth.auth().signIn(with: credential) { (user, error) in
                print("trying to sign in .....")
                if error != nil {
                    print("Erreur de firebase ===== ", error.debugDescription)
                    return
                }
                let databaseRoot = Database.database().reference()
                let userInfo = Auth.auth().currentUser
                let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
                print((userInfo?.providerData[0].uid)!)
                let photoURL = "https://graph.facebook.com/" + (userInfo?.providerData[0].uid)! + "/picture?type=large"
                let values = ["email": userInfo?.email, "name": userInfo?.displayName, "photoURL": /*userInfo?.photoURL?.absoluteString*/photoURL] as! [String : String]
                
                userRef.updateChildValues(values, withCompletionBlock: {(error, ref) in
                    if error != nil {
                        print(error.debugDescription)
                        return
                    }
                })
                print("successfully firebased")
                self.showHomeController()
            }
        }
    }
}
