//
//  NewsCustomCell.swift
//  News App
//
//  Created by Aly Essam on 12/20/19.
//  Copyright © 2019 Aly Essam. All rights reserved.
//

import UIKit

class NewsCustomCell: UITableViewCell, UINavigationControllerDelegate {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var newsPicture: UIImageView!
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var publishedAt: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var showMoreButton: UIButton!
    // @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
        
}
  
    
    


