//
//  SnapsViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/11/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit
import Firebase

class SnapsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var snaps : [Snap] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    //If segue presented modally we can just dismiss it
    //to go back to the login screen
    @IBAction func logout_tapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Retrieve list of all users in database
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //Runs everytime a snap is added
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childAdded, with: {(snapshot) in
           let snap = Snap()
           let value = snapshot.value as? NSDictionary
           snap.imageURL = value?["imageURL"] as? String ?? ""
           snap.descrip = value?["description"] as? String ?? ""
           snap.from = value?["from"] as? String ?? ""
           snap.key = snapshot.key
           snap.uuid = value?["uuid"] as? String ?? ""
           self.snaps.append(snap)
           self.tableView.reloadData()
        })
        //Runs everytime a snap is removed
        Database.database().reference().child("users").child(Auth.auth().currentUser!.uid).child("snaps").observe(DataEventType.childRemoved, with: {(snapshot) in
            var index = 0
            for snap in self.snaps {
                if(snap.key == snapshot.key) {
                    self.snaps.remove(at: index)
                }
                index += 1
            }
            self.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if snaps.count == 0{
            return 1
        }
        else {
            return snaps.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if snaps.count == 0{
            let cell = UITableViewCell()
            cell.textLabel?.text = "You have no snaps :("
            return cell
        }
        else {
            let cell = UITableViewCell()
            let snap = snaps[indexPath.row]
            cell.textLabel?.text = snap.from
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snap = snaps[indexPath.row]
        performSegue(withIdentifier: "view_snaps_segue", sender: snap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "view_snaps_segue"){
            let nextVC = segue.destination as! ViewSnapController
            nextVC.snap = sender as! Snap
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
