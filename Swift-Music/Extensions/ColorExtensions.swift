//
//  ColorExtensions.swift
//  Swift-Music
//
//  Created by James Shaw on 23/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let appNavy = UIColor(red: 22/255, green:21/255, blue:28/255, alpha: 1)

    var isLight: Bool {
        var white: CGFloat = 0
        getWhite(&white, alpha: nil)
        return white > 0.5
    }
}
