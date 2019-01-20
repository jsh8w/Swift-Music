//
//  APIManager.swift
//  Swift-Music
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

    func get(endpoint: Endpoint, completion: @escaping ([String: Any]?, Error?) -> Void) {
        let url = "\(self.baseUrl)\(endpoint.method)\(self.apiKey)"

        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    completion(json, nil)
                    return
                }
            }
            .responseString { response in
                completion(nil, response.result.error)
                return
        }
    }
}
