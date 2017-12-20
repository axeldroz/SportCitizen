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

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet weak var facebookLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let loginButton: FBSDKLoginButton = FBSDKLoginButton()
       loginButton.center = self.view.center
       view.addSubview(loginButton)
       loginButton.readPermissions = ["public_profile", "email"]
        loginButton.delegate = self
        view.addSubview(facebookLoginButton)
        facebookLoginButton.addTarget(self, action: #selector(customFacebookLogin), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func customFacebookLogin(sender: UIButton!) {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"], from: self) {
            (result, error) in
            if error != nil {
                print("Custom login failed: ", error.debugDescription)
                return
            }
            let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            Auth.auth().signIn(with: credential) { (user, error) in
                if error != nil {
                    print("Erreur de firebase ===== ", error.debugDescription)
                    return
                }
                print("successfully firebased")
            }
            print("successfully logged")
            let databaseRoot = Database.database().reference()
            let userInfo = Auth.auth().currentUser
            let userRef = databaseRoot.child("users").child((userInfo?.uid)!)
            let values = ["email": userInfo?.email , "name": userInfo?.displayName, "photoURL": userInfo?.photoURL?.absoluteString]
                
            userRef.updateChildValues(values, withCompletionBlock: {(err, ref) in
                if error != nil {
                    print(error.debugDescription)
                    return
                }
            })
        }
        

    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Logged out")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                   print(error)
                   return
               }
                print("successfully firebased")
            }
        print("successfully logged")
    }
}
