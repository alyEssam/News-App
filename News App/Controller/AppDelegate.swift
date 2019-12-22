//
//  AppDelegate.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn

@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {
    var providerID = ""



    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
              print("The user has not signed in before or they have since signed out.")
                print("\(error.localizedDescription)")
            } else {
              print("\(error.localizedDescription)")
            }
            return
          }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
          if let error = error {
            print("Cannot login using Google")
            print("\(error.localizedDescription)")
            return
          }
          // User is signed in
          // ...
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
          // Perform any operations when the user disconnects from app here.
        // ...
    }
    
     var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //Configure Google SignIn
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self

        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                //User is loggin
                
                print("User is logginn \(user.email ?? "")")
                for profile in (user.providerData) {
                    self.providerID = profile.providerID
                    }
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainVC")

                self.window?.rootViewController = vc

            }
            else{
                //User is logged Out
                if self.providerID == "facebook.com" {
                    //loginButtonDidLogOut
                    print("Facebook Logged Out")
                }
                else if self.providerID == "google.com" {
                    GIDSignIn.sharedInstance().signOut()
                }
               print("User logged out")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "welcomeVC")
                self.window?.rootViewController = vc
            }
        }
        return true
    }

    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
      return ApplicationDelegate.shared.application(
        application,
        open: url,
        sourceApplication: sourceApplication,
        annotation: annotation
      )
    }
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
      return GIDSignIn.sharedInstance().handle(url)
    }

}

