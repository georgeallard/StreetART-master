//
//  SocialTableViewCell.swift
//  StreetART
//
//  Created by George Allard (i7259568) on 03/06/2017.
//  Copyright © 2017 George Allard. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var urlButton: UIButton!

    
    @IBAction func urlButton(_ sender: Any) {
        if let url = NSURL(string: "http://uk.complex.com/style/2012/07/the-10-coolest-street-artist-websites/"){
            UIApplication.shared.openURL(url as URL)
        }
    }
}
