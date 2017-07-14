//
//  SignInViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/7/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func sign_in_button(_ sender: Any) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            print("We tried to sign in")
            if(error != nil){
                print("We have an error: \(String(describing: error))")
                Auth.auth().createUser(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                    if(error != nil){
                        print("We have an error: \(String(describing: error))")
                    }
                    else{
                        print("Created user successfully")
                        //Add user into database
                        let users = Database.database().reference().child("users")
                        
                    users.child(user!.uid).child("email").setValue(user!.email!)
                        
                        self.performSegue(withIdentifier: "SignInSegue", sender: nil)
                    }
                }
            } else {
                print("Signed in sucessfully")
                self.performSegue(withIdentifier: "SignInSegue", sender: nil)
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

