//
//  APIManager.swift
//  Swift-Weather
//
//  Created by James Shaw on 19/01/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit
import Alamofire

enum Endpoint {
    case ChartsTopArtists

    var method: String {
        switch self {
        case .ChartsTopArtists:
            return "chart.gettopartists"
        }
    }
}

class APIManager: NSObject {
    static let shared = APIManager()
    let baseUrl = "http://ws.audioscrobbler.com/2.0/?method="
    let apiKey = "&api_key=\(APIConfig.apiKey)&format=json"

    func get(endpoint: Endpoint) {
        let url = "\(self.baseUrl)\(endpoint.method)\(self.apiKey)"

        Alamofire.request(url, method: .get)
            .responseJSON { response in
                // handle JSON
            }
            .responseString { response in
                if let error = response.result.error {
                    print(error)
                }
                if let value = response.result.value {
                    print(value)
                }
        }
    }
}
