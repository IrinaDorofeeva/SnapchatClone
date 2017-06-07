//
//  SignInViewController.swift
//  SnapchatClone
//
//  Created by Mac on 6/6/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import FirebaseAuth


class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func turnUpTapped(_ sender: Any) {
        
        
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            print("We tried to sign in")
            if error != nil{
                print ("error:\(error)")
                
                
                Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    if error != nil{
                        print ("error:\(error)")}
                    else {
                    print ("user created")
                        self.performSegue(withIdentifier: "signIn", sender: nil)
                    }
                })
                
            } else {
                print("Signed in")
                self.performSegue(withIdentifier: "signIn", sender: nil)
            }
            
        }
        
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

