//
//  SceneDelegate.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let _ = (scene as? UIWindowScene) else { return }
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user{
                //User is loggin
                print("User is logginn \(user.email ?? "")")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainVC")
                self.window?.rootViewController = vc

            }
            else{
                //User is logged Out
               print("User logged out")
                let sb = UIStoryboard(name: "Main", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "welcomeVC")
                self.window?.rootViewController = vc
            }
        }
    }
}

