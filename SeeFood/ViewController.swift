//
//  ViewController.swift
//  SeeFood
//
//  Created by Tran Le on 4/19/20.
//  Copyright © 2020 TL Inc. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {

    @IBOutlet weak var foodImageView: UIImageView!
    
    //for user to pick image from camera roll
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera //replace with .photoLibrary if want to access camera library
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //info contains the image user picked
        
        //get image user has selected
        if let userImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            //set storyboard imageView as userImage
            foodImageView.image = userImage
        }
        
        //dismiss imagePicker once picked
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        //when tapped on camera, imagePicker shows
        present(imagePicker, animated: true, completion: nil )
    }
    


}

