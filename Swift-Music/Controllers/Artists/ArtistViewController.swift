//
//  ArtistViewController.swift
//  Swift-Music
//
//  Created by James Shaw on 24/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class ArtistViewController: BaseViewController {

    var artist: Artist!

    class func instantiateFromStoryboard(artist: Artist) -> ArtistViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ArtistViewController") as! ArtistViewController
        vc.artist = artist
        vc.title = artist.name
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
