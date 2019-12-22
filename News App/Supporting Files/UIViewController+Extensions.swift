//
//  UIViewController+Extensions.swift
//  News App
//
//  Created by Aly Essam on 12/19/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    
// Mark: -- Alert Method
/***************************************************************/
    
 func showAlert(title: String, message: String, okTitle: String = "Ok"){
     let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
     alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: nil))
     present(alert, animated: true, completion: nil)
    }
    
 func raiseAlertView(withTitle: String, withMessage: String) {
        
      let alertController = UIAlertController(title: withTitle, message: withMessage, preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
      present(alertController, animated: true)
    }
    
          /** Keyboard functions **/
          func subscribeToKeyboardNotifications() {
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
          }
   
          func unsubscribeFromKeyboardNotifications() {
              NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
              NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
          }
          // When the keyboardWillShow notification is received, shift the view's frame up
          @objc func keyboardWillShow(_ notification:Notification) {
                  view.frame.origin.y = -getKeyboardHeight(notification)
          }
          // When the keyboardWillHide notification is received, shift the view's frame down
          @objc func keyboardWillHide(_ notification:Notification) {
              view.frame.origin.y = 0
          }
          //To get the height of the Keyboard
          func getKeyboardHeight(_ notification:Notification) -> CGFloat {
              let userInfo = notification.userInfo
              let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
              return keyboardSize.cgRectValue.height
          }
       //Hide keyboard when tapped outside it
       func hideKeyboardWhenTappedAround() {
           let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           tap.cancelsTouchesInView = false
           view.addGestureRecognizer(tap)
       }
       @objc func dismissKeyboard() {
           view.endEditing(true)
       }
}

