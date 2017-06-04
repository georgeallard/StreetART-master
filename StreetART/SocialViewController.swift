//
//  SocialViewController.swift
//  StreetART
//
//  Created by George Allard (i7259568) on 03/06/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit

class SocialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    

        // Do any additional setup after loading the view.
    }
    

    let aboutWebsites = ["Bristol's street art scene is extremely diverse and has many talented street artists at its forefront. This website aims to catalogue past and present work by collecting photographs and logging the location of these street art pieces.",
                         "We think the World is slowly starting to wake up to why our cities shold be painted and steps we can take to get there. We want new conversations around public space and participation. The future is painted.",
                         "Faile",
                         "Gaia",
                         "DABSMYLA",
                         "OSGEMEOS",
                         "Retna",
                         "Phlegm"]
    
    let imagesOfWeb = ["Bristol Street Art", "Global Street Art", "Faile", "Gaia", "DABSMYLA", "OSGEMEOS", "Retna", "Phlegm"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (imagesOfWeb.count)
    }

 

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SocialTableViewCell
        
        
        
        cell.myImage.image = UIImage(named: (imagesOfWeb[indexPath.row] + ".jpg"))
        
        cell.myLabel.text = imagesOfWeb[indexPath.row]
       
        cell.about.text = aboutWebsites[indexPath.row]
    
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            cell.alpha = 1
        })
        
        return (cell)
        
    }


    
    




    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
