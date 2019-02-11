//
//  ArtistsCollectionView.swift
//  Swift-Music
//
//  Created by James Shaw on 10/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class ArtistsCollectionView: UICollectionView {

    var data:[Artist] = []

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
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
    }

    func setData(data: [Artist]) {
        self.data = data
        self.reloadData()
    }
}

extension ArtistsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArtistCell", for: indexPath) as! ArtistCollectionViewCell
        let artist = self.data[indexPath.row]
        cell.setup(artist: artist)
        return cell
    }
}
