//
//  ChartsManager.swift
//  Swift-Weather
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class ChartsManager: NSObject {
    static let shared = ChartsManager()

    func topArtists() {
        APIManager.shared.get(endpoint: .ChartsTopArtists)
    }
}
