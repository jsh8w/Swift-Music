//
//  TabBarController.swift
//  Swift-Music
//
//  Created by James Shaw on 11/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupUI()
    }

    private func setupUI() {
        self.tabBar.barTintColor = .clear
        self.tabBar.tintColor = .white

        guard let items = self.tabBar.items else { return }
        let uploadItem = items.first!
        uploadItem.image = UIImage(named: "TabUpload")
        uploadItem.selectedImage = UIImage(named: "TabUploadSelected")
        uploadItem.title = "Artists"
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .regular)]
        uploadItem.setTitleTextAttributes(attributes, for: .normal)
    }
}

