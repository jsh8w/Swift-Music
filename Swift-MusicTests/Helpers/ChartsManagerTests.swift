//
//  ChartsManagerTests.swift
//  Swift-MusicTests
//
//  Created by James Shaw on 20/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import XCTest
@testable import Swift_Music

class ChartsManagerTests: XCTestCase {

    var json: [String: Any] = [:]

    override func setUp() {
        self.json = MockContent.shared.topArtistsJSON()
    }

    func testParseTopArtists() {
        let artists = ChartsManager.shared.parseTopArtists(json: self.json)
        XCTAssertEqual(artists.count, 50)
        XCTAssertEqual(artists.first!.name, "Ariana Grande")
        XCTAssertEqual(artists.first!.playCount, 83758049)
        XCTAssertEqual(artists.first!.listeners, 1047470)
        XCTAssertEqual(artists.first!.url, "https://www.last.fm/music/Ariana+Grande")

        let url = "https://lastfm-img2.akamaized.net/i/u/300x300/8cdd6aee7cea79ccabf13cd3ed382801.png"
        XCTAssertEqual(artists.first!.imageUrl, url)
    }
}
