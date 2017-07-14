//
//  SelectUserViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/12/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit
import Firebase

class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableView: UITableView!
//    @IBAction func back_to_snaps(_ sender: Any) {
//        print("Back to snaps")
//        self.performSegue(withIdentifier: "back_to_snaps_segue", sender: nil)
//    }
    
    
    var users : [User] = []
    var uuid = ""
    var imageURL = ""
    var descrip = ""
    
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        let snap = ["from":Auth.auth().currentUser!.email!,"description":descrip,"imageURL":imageURL,"uuid":uuid]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
        navigationController!.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
       //Retrieve list of all users in database
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
            let user = User()
            let value = snapshot.value as? NSDictionary
            let email = value?["email"] as? String ?? ""
            user.email = email
            user.uid = snapshot.key
            self.users.append(user)
            self.tableView.reloadData()
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
