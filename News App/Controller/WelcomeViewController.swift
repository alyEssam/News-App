//
//  WelcomeViewController.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn


class WelcomeViewController: UIViewController {

    @IBOutlet weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
         GIDSignIn.sharedInstance()?.presentingViewController = self

    }


    @IBAction func facebookLogIn(_ sender: UIButton){
        let manager = LoginManager()
          manager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
                if let error = error{
                  self.showAlert(title: "Error", message: error.localizedDescription)
                       }
                    else {
                        if !result!.isCancelled{
                         let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                         Auth.auth().signIn(with: credential) { (authResult, error) in
                         if let error = error {
                            self.showAlert(title: "Error", message: error.localizedDescription)
                               }
                         else {
                                print("User is signed in")
                            for profile in (authResult?.user.providerData)! {
                                print(profile.displayName ?? "" )
                                print(profile.phoneNumber ?? "")
                                print(profile.email ?? "")
                                print(profile.providerID)
                                print(profile.photoURL!)
                            }
                                print(authResult?.user.displayName ?? "" )
                                print(authResult?.user.phoneNumber ?? "")
                                print(authResult?.user.email ?? "")
                                print(authResult?.user.providerID ?? "")
                                print(authResult?.user.photoURL! ?? "")
                              }
                            }

                        }
                    }
          }
    }
    @IBAction func didTapSignOut(_ sender: GIDSignInButton) {
        GIDSignIn.sharedInstance()?.signIn()
    }

}
