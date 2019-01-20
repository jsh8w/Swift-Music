//
//  Artist.swift
//  Swift-Music
//
//  Created by James Shaw on 20/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class Artist: NSObject {
    var name: String!
    var playCount: Int!
    var listeners: Int!
    var url: String!
    var imageUrl: String?

    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""
        self.playCount = json["playcount"] as? Int ?? 0
        self.listeners = json["listeners"] as? Int ?? 0
        self.url = json["url"] as? String ?? ""

        guard let imageObjects = json["image"] as? [[String: String]] else { return }
        guard let imageObject = imageObjects.first(where: { $0["size"] == "extralarge" }) else { return }
        self.imageUrl = imageObject["#text"] 
    }
}
