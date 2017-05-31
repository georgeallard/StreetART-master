//
//  UploadViewController.swift
//  StreetART
//
//  Created by George Allard on 12/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var selectBtn: UIButton!
    
    var picker = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logo = UIImage(named: "streetARNAV")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
        picker.delegate = self
        
    }
    
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                self.previewImage.image = image
                selectBtn.isHidden = true
                postBtn.isHidden = false
                
            }
            
            self.dismiss(animated: true, completion: nil)
    

    }
    
//    func checkIfUserIsLoggedIn() {
//        if FIRAuth.auth()?.currentUser?.uid == nil {
//            perform(#selector(handlelogout), with: nil, afterDelay: 0)
//        } else {
//            let uid = FIRAuth.auth()?.currentUser?.uid
//            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
//                
//                if let dictionary = snapshot.value as? [String: AnyObject] {
//                    self.navigationItem.title = dictionary ["name"] as? String
//                }
//                
//                
//            }, withCancel: nil)
//        }

    @IBAction func selectPressed(_ sender: Any) {
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        
        self.present(picker, animated: true, completion: nil)
        
    }
    
    @IBAction func postPressed(_ sender: Any) {
        
         AppDelegate.instance().showActivityIndicator()
    
        let uid = FIRAuth.auth()!.currentUser!.uid
        let ref = FIRDatabase.database().reference()
        let storage = FIRStorage.storage().reference(forURL: "gs://streetart-9f907.appspot.com")
        
        let key = ref.child("posts").childByAutoId().key
        let imageRef = storage.child("posts").child(uid).child("\(key).jpg")
        
        let data = UIImageJPEGRepresentation(self.previewImage.image!, 0.6)
        
        let uploadTask = imageRef.put(data!, metadata: nil) { (metadata, error) in
            if error != nil {
                print(error!.localizedDescription)
                AppDelegate.instance().dismissActivityIndicatos()
                return
            }
            
            imageRef.downloadURL(completion: { (url, error) in
                if let url = url {
                    let feed = ["userID" : uid,
                                "pathToImage" : url.absoluteString,
                                "likes" : 0,
                                "author" : FIRAuth.auth()!.currentUser!.displayName!,
                                "postID" : key] as [String : Any]
                    
                    
                    let postFeed = ["\(key)" : feed]
                    
                    ref.child("posts").updateChildValues(postFeed)
                    AppDelegate.instance().dismissActivityIndicatos()
                    
                    
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
        }
        
        uploadTask.resume()
        
    }
    
}

        
    
