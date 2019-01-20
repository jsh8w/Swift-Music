//
//  ChartsManager.swift
//  Swift-Music
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

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
}
