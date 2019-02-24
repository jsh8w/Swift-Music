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
    @IBOutlet weak var spinner: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.updateData()
    }

    private func setupUI() {
        self.artistsCollectionView.navigationDelegate = self
        self.title = "Popular"
        self.spinner.startAnimating()
    }

    private func updateData() {
        self.spinner.startAnimating()
        self.artistsCollectionView.visibleCells.forEach { $0.alpha = 0.0 }
        ChartsManager.shared.topArtists { (artists, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    self.spinner.stopAnimating()
                    return
                }

                self.artistsCollectionView.setData(data: artists)
                let fromAnimation = AnimationType.from(direction: .bottom, offset: 150.0)
                self.artistsCollectionView.animate(animations: [fromAnimation], duration: 0.4)
                self.spinner.stopAnimating()
            }
        }
    }
}

extension ArtistsViewController: ArtistsCollectionViewDelegate {
    func didSelect(artist: Artist) {
        let vc = ArtistViewController.instantiateFromStoryboard(artist: artist)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

