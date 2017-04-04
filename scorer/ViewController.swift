//
//  ViewController.swift
//  scorer
//
//  Created by David Yuan on 3/30/17.
//  Copyright © 2017 David Yuan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imageToUpload: UIImage? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func uploadButton(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(vc, animated:true, completion:nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.imageToUpload = editedImage
        
        self.dismiss(animated: true, completion: nil)
        self.performSegue(withIdentifier: "d", sender: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoViewController
        
            vc.tempimage = imageToUpload
        
    }


}

