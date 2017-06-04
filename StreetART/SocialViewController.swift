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
                         "FAILE's website starts out looking like a simple blog. Don't be fooled. Investigate fully and you'll be rewarded with multiple galleries and brilliant images. Need more, you can buy the FAILE Temple Book direct too.",
                         "Baltimore's Gaia has a paired down, direct website that properly highlights street work from 2007 to the present. There is also space for gallery work, the Legacy project, specific commissions, and resume. While the design might not wow, it perfectly articulates the activity of one of street art's most thoughtful participants.",
                         "Australia's finest street art couple not only kill it on the street, they know how to captivate on the web as well. Their site includes all of their varied work. The associated blog shares some laughs and news of their friends too. Plus, if you want to have some DabsMyla in your own home, they've got a store to sort you out.",
                         "With the support of the family, and the arrival of Hip Hop culture in Brazil in the 80's, OSGEMEOS found a direct connection with its magical and dynamic universe and a way of communicating with the public.",
                         "Retna's site wins with a full screen slide show, offering close up works of his calligraphy-based graffiti. Along the journey you'll see his work on planes, in print, and on the side of buildings. There are also videos on the site.",
                         "Phlegm is getting well known. Phlegm is also prolific. His site doesn't have many bells and whistles, nor does it require any. Instead, you just get frequent updates of outdoor painting and smaller scale drawings that never fail to entertain and amuse."]
    
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
