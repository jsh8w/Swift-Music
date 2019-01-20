//
//  MockContent.swift
//  Swift-Music
//
//  Created by James Shaw on 20/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class MockContent: NSObject {
    static let shared = MockContent()

    func topArtistsJSON() -> [String: Any] {
        guard let path = Bundle.main.path(forResource: "TopArtists", ofType: "json") else { return [:] }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

            guard let jsonDict = jsonResult as? [String: Any] else { return [:] }
            return jsonDict
        } catch {
            return [:]
        }
    }
}
