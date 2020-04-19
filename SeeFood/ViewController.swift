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
            
            //convert UIImage to CIImage (for CoreML)
            guard let ciImage = CIImage(image: userImage) else {
                fatalError("Could not convert UIImage to CIImage")
            }
            
            detect(image: ciImage)
        
        }
        
        //dismiss imagePicker once picked
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func detect(image: CIImage) {
        
        //VNCoreMLModel is a container for Core ML Model -> comes from Vision framework
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("CoreML Model Inception Model failed to load")
        }
        
        //create request to process image in CoreML model
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Could not get classification observation of image")
            }
            
            print(results)
        }
        
        //specify which image to classify
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
        try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        //when tapped on camera, imagePicker shows
        present(imagePicker, animated: true, completion: nil )
    }
    


}

