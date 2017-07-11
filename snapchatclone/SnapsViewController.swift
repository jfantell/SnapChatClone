//
//  SnapsViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/11/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit

class SnapsViewController: UIViewController {

    //If segue presented modally we can just dismiss it
    //to go back to the login screen
    @IBAction func logout_tapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
