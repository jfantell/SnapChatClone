//
//  PictureViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/11/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit
import Firebase

class PictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var description_text: UITextField!
    
    var imagePicker: UIImagePickerController!
    var uuid = NSUUID().uuidString
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nextButton.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    //Get photos from camera
    @IBAction func camera_tapped(_ sender: Any) {
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    //Save photo to uiimage view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageview.image = image
        }
        nextButton.isEnabled = true
        picker.dismiss(animated: true, completion: nil);
    }
    
    @IBAction func next_tapped(_ sender: Any) {
        
        nextButton.isEnabled = false
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        
        // Data in memory
        let imageData = UIImageJPEGRepresentation(imageview.image!, 0.1)
        
        
        // Create a reference to the file you want to upload
        let image_upload = storageRef.child("images/\(uuid).jpg")
        
        // Upload the file to the path "images/images.png"
        _ = image_upload.putData(imageData!, metadata: nil) { (metadata, error) in
            print("We tried uploading the image!!")
            if(error != nil){
                print("Error!!!!")
            } else {
                self.performSegue(withIdentifier: "selectUserSegue", sender: metadata?.downloadURL()?.absoluteString)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! SelectUserViewController
        nextVC.imageURL = sender as! String
        nextVC.descrip = description_text.text!
        nextVC.uuid = uuid
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
