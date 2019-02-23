//
//  ChartsManager.swift
//  Swift-Music
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire

class ChartsManager: NSObject {
    static let shared = ChartsManager()

    func topArtists(completion: @escaping ([Artist], Error?) -> Void) {
        APIManager.shared.get(endpoint: .ChartsTopArtists) { (json, error) in
            guard let json = json, error == nil else {
                completion([], error)
                return
            }

            let artists = self.parseTopArtists(json: json)
            completion(artists, nil)
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
                    artist.backgroundColor = colors.background
                    artist.image = image
                    completion(artist)
                })
        }
    }
}
