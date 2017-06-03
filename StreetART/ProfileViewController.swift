//
//  ProfileViewController.swift
//  StreetART
//
//  Created by George Allard on 16/05/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SDWebImage

class ProfileViewController: UIViewController, UICollectionViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var imageCollection: UICollectionView!
    @IBOutlet weak var profilePicture: UIImageView!
    
   
    var customImageFlowLayout: CustomImageFlowLayout!
    var dataBaseRef: FIRDatabaseReference!
    var storageRef: FIRStorage!
    var images = [UserImage]()
    var dbRef: FIRDatabaseReference!

    
    override func viewDidLoad() {
        
        dataBaseRef = FIRDatabase.database().reference()
       
        loadProfileData()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    
        let logo = UIImage(named: "streetARNAV")
        let imageView = UIImageView(image: logo)
        self.navigationItem.titleView = imageView
        
    
        dbRef = FIRDatabase.database().reference().child("posts")
        
        loadDB()
        
        loadProfileData()
        
        customImageFlowLayout = CustomImageFlowLayout()
        
        imageCollection.collectionViewLayout = customImageFlowLayout
        
        imageCollection.backgroundColor = .white
       
        dataBaseRef = FIRDatabase.database().reference()
        
    
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            
            dataBaseRef.child("users").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
                
                let dictionary = snapshot.value as? NSDictionary
                
                let fullname = dictionary?["full name"] as? String ?? "Full Name"
                
                if let profilePictureURL = dictionary?["urlToImage"]as? String{
                    
                    let url = URL(string: profilePictureURL)
                    
                    URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                        
                        if error != nil{
                            print(error!)
                            return
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.profilePicture.image = UIImage(data: data!)
                            
                        }
                    }) . resume()
                }
                
                self.name.text = fullname
                
            }) { (error) in
                print(error.localizedDescription)
                return
            
            }
        }
    
    }
    
    
    
    
    
    
    func loadDB() {
        
        dbRef.observe(FIRDataEventType.value, with: { (snapshot) in
            var newImages = [UserImage]()
            
            for userImageSnapshot in snapshot.children {
                
                let userImageObject = UserImage(snapshot: userImageSnapshot as! FIRDataSnapshot)
                newImages.append(userImageObject)
            }
            
            self.images = newImages
            self.imageCollection.reloadData()

        
    })
    
}



    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return images.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! imageCollectionViewCell
        
        let image = images[indexPath.row]

       cell.imageView.sd_setImage(with: URL(string: image.pathToImage), placeholderImage: UIImage(named:"image1"))
        
        return cell
        
        
    }
    
    func loadProfileData(){
        
        if let userID = FIRAuth.auth()?.currentUser?.uid {
            dataBaseRef.child("users").child(userID).observe(.value, with: { (snapshot) in
                
                let values = snapshot.value as? NSDictionary
                
                if let profilePicture = values?["urlToImage"] as? String{
                    
                    self.profilePicture.sd_setImage(with: URL(string: profilePicture))
                }
                
                self.name.text = values?["full name"] as? String
                
                self.about.text = values?["about"] as? String
                
                
            })
            
        }
    }
    

    

}

