//
//  ViewSnapController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/13/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase

class ViewSnapController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var snap_label: UILabel!
    
    var snap = Snap()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        snap_label.text = snap.descrip
        imageView.sd_setImage(with: URL(string: snap.imageURL))
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").child(snap.key).removeValue()
            print("Successfully delted snap")
        
        Storage.storage().reference().child("images").child("\(snap.uuid).jpg").delete { (error) in
            print("Deleted pic from db")
        }
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


