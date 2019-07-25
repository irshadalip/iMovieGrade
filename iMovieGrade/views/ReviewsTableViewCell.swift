//
//  ReviewsTableViewCell.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 15/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var reviews: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileName.text = Auth.auth().currentUser?.displayName
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width / 2
        profileImage.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
