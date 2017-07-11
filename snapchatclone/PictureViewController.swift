//
//  PictureViewController.swift
//  snapchatclone
//
//  Created by John Fantell on 7/11/17.
//  Copyright © 2017 John Fantell. All rights reserved.
//

import UIKit

class PictureViewController: UIImagePickerController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var description_text: UITextField!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    //Settings for uiimageview
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageview.image = image
        }
        else{
            print("Error!!!!\n")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    //Get photos from camera
    @IBAction func camera_tapped(_ sender: Any) {
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func next_tapped(_ sender: Any) {
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
