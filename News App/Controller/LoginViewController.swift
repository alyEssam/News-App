//
//  LoginViewController.swift
//  News App
//
//  Created by Aly Essam on 12/23/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        SVProgressHUD.show()
        
        //TODO: Log in the user
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!)
            }
            else{
                print("login successful")
                
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToNewsViewController", sender: self)
            }
        })
        
        
    }
    


    
}

