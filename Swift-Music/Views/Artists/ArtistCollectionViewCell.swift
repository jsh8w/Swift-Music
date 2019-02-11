//
//  ArtistCollectionViewCell.swift
//  Swift-Music
//
//  Created by James Shaw on 10/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire

class ArtistCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!

    override func layoutSubviews() {
        super.layoutSubviews()

        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = self.imageView.bounds.height / 2.0
        self.imageView.clipsToBounds = true
    }

    func setup(artist: Artist) {
        self.label.text = artist.name

        guard let urlString = artist.imageUrl else { return }
        guard let url = URL(string: urlString) else { return }

        Alamofire.request(url, method: .get)
            .responseData { response in
                guard let data = response.data else { return }
                let image = UIImage(data: data)
                self.imageView.image = image
            }
    }
}
