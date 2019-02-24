//
//  ChartsManager.swift
//  Swift-Music
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire
import UIImageColors

class ChartsManager: NSObject {
    static let shared = ChartsManager()

    func topArtists(completion: @escaping ([Artist], Error?) -> Void) {
        APIManager.shared.get(endpoint: .ChartsTopArtists) { (json, error) in
            guard let json = json, error == nil else {
                completion([], error)
                return
            }

            var artists = self.parseTopArtists(json: json)

            guard artists.count >= 6 else {
                completion(artists, nil)
                return
            }

            let group = DispatchGroup()
            for index in 0...5 {
                let artist = artists[index]
                group.enter()
                self.downloadImage(artist: artist, completion: { (newArtist) in
                    artists[index] = newArtist
                    group.leave()
                })
            }

            group.notify(queue: .main, execute: {
                completion(artists, nil)
            })
        }
    }

    func parseTopArtists(json: [String: Any]) -> [Artist] {
        guard let artistsJSON = json["artists"] as? [String: Any],
            let artistsArrayJSON = artistsJSON["artist"] as? [[String: Any]] else {
                return []
        }

        var artists: [Artist] = []

        for artistJSON in artistsArrayJSON {
            let artist = Artist(json: artistJSON)
            artists.append(artist)
        }

        return artists
    }

    func downloadImage(artist: Artist, completion: @escaping (Artist) -> Void) {
        guard artist.backgroundColor == nil || artist.image == nil else {
            completion(artist)
            return
        }

        guard let urlString = artist.imageUrl, let url = URL(string: urlString) else {
            completion(artist)
            return
        }

        Alamofire.request(url, method: .get)
            .responseData { response in
                guard let data = response.data else { return }
                guard let image = UIImage(data: data) else { return }

                image.getColors(quality: .lowest, { (colors) in
                    artist.backgroundColor = self.getColor(colors: colors)
                    artist.image = image
                    completion(artist)
                })
        }
    }

    private func getColor(colors: UIImageColors) -> UIColor {
        if !colors.primary.isLight {
            return colors.primary
        }

        if !colors.background.isLight {
            return colors.background
        }

        if !colors.secondary.isLight {
            return colors.secondary
        }

        if !colors.detail.isLight {
            return colors.detail
        }

        return UIColor.darkGray
    }
}
