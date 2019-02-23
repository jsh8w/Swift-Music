//
//  ViewController.swift
//  Swift-Music
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import ViewAnimator

class ArtistsViewController: BaseViewController {

    @IBOutlet weak var artistsCollectionView: ArtistsCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.updateData()
    }

    private func setupUI() {
        
    }

    private func updateData() {
        ChartsManager.shared.topArtists { (artists, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    return
                }

                self.artistsCollectionView.setData(data: artists)
                let fromAnimation = AnimationType.from(direction: .bottom, offset: 50.0)
                let zoomAnimation = AnimationType.zoom(scale: 0.2)
                UIView.animate(views: self.artistsCollectionView.visibleCells,
                               animations: [fromAnimation, zoomAnimation],
                               duration: 0.25)
            }
        }
    }
}

