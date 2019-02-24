//
//  ArtistsCollectionView.swift
//  Swift-Music
//
//  Created by James Shaw on 10/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire
import UIImageColors

protocol ArtistsCollectionViewDelegate {
    func didSelect(artist: Artist)
}

class ArtistsCollectionView: UICollectionView {

    var data:[Artist] = []
    var navigationDelegate: ArtistsCollectionViewDelegate?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.commonInit()
    }

    private func commonInit() {
        self.delegate = self
        self.dataSource = self
        self.prefetchDataSource = self
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.backgroundColor = UIColor.appNavy
    }

    func setData(data: [Artist]) {
        self.data = data
        self.reloadData()
    }
}

extension ArtistsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as! ArtistCollectionViewCell
        let artist = self.data[indexPath.row]
        cell.label.text = artist.name
        cell.imageView.image = nil
        cell.roundedView.backgroundColor = .clear

        ChartsManager.shared.downloadImage(artist: artist) { (updatedArtist) in
            self.data[indexPath.row] = updatedArtist
            cell.imageView.image = updatedArtist.image
            cell.roundedView.backgroundColor = updatedArtist.backgroundColor
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let artist = self.data[indexPath.row]
            ChartsManager.shared.downloadImage(artist: artist) { (updatedArtist) in
                self.data[indexPath.row] = updatedArtist
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let artist = self.data[indexPath.row]
        self.navigationDelegate?.didSelect(artist: artist)
    }
}

extension ArtistsCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let collectionViewWidth = (collectionView.bounds.width / 2.0) - 10.0
        let collectionViewHeight = collectionViewWidth * 1.5
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
}
