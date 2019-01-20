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
    var playCount: Int = 0
    var listeners: Int = 0
    var url: String!
    var imageUrl: String?

    init(json: [String: Any]) {
        self.name = json["name"] as? String ?? ""

        if let playCount = json["playcount"] as? String {
            self.playCount = Int(playCount) ?? 0
        }

        if let listeners = json["listeners"] as? String {
            self.listeners = Int(listeners) ?? 0
        }
        
        self.url = json["url"] as? String ?? ""

        guard let imageObjects = json["image"] as? [[String: String]] else { return }
        guard let imageObject = imageObjects.first(where: { $0["size"] == "extralarge" }) else { return }
        self.imageUrl = imageObject["#text"] 
    }
}
