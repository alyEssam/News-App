//
//  RegisterViewController.swift
//  News App
//
//  Created by Aly Essam on 12/23/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD


class RegisterViewController: UIViewController {

    
    //Pre-linked IBOutlets

    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

  
    @IBAction func registerPressed(_ sender: AnyObject) {
        
        SVProgressHUD.show()
        

        
        //TODO: Set up a new user on our Firbase database
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            
            if error != nil {
                print(error!)
                
            } else {
                //success
                print("Registration successful")
                
                SVProgressHUD.dismiss()
                
                // in closure, we have to tell the compiler where does this closure take place by using "self"
                self.performSegue(withIdentifier: "goToNewsViewController", sender: self)
            }
        })
        
        

        
        
    }
    
    
}
