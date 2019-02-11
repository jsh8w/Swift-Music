//
//  ViewController.swift
//  Swift-Music
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import ViewAnimator

class HomeViewController: BaseViewController {

    @IBOutlet weak var artistsCollectionView: ArtistsCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.updateData()
    }

    func updateData() {
        ChartsManager.shared.topArtists { (artists, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }

                self.artistsCollectionView.setData(data: artists)
                let fromAnimation = AnimationType.from(direction: .right, offset: 50.0)
                let zoomAnimation = AnimationType.zoom(scale: 0.1)
                UIView.animate(views: self.artistsCollectionView.visibleCells,
                               animations: [fromAnimation, zoomAnimation],
                               duration: 0.25)
            }
        }
    }
}

