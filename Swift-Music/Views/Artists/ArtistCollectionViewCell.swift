//
//  ArtistCollectionViewCell.swift
//  Swift-Music
//
//  Created by James Shaw on 10/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire
import UIImageColors

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundedView.layer.masksToBounds = true
        self.roundedView.layer.cornerRadius = 12.0
        self.roundedView.clipsToBounds = true
    }
}
