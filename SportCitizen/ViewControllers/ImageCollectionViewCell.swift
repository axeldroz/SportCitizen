//
//  ImageCollectionViewCell.swift
//  SportCitizen
//
//  Created by Simon BRAMI on 20/12/2017.
//  Copyright © 2017 Simon BRAMI. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
        self.titleLabel.text = nil
        self.DescriptionLabel.text = nil
        self.locationLabel.text = nil
    }
}
