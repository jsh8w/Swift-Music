//
//  BaseViewController.swift
//  Swift-Music
//
//  Created by James Shaw on 11/02/2019.
//  Copyright © 2019 James Shaw. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBaseUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.setNeedsStatusBarAppearanceUpdate()
    }

    private func setupBaseUI() {
        self.view.backgroundColor = UIColor.appNavy
        self.setupNavigationBar()
    }

    private func setupNavigationBar() {
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        navigationBar.prefersLargeTitles = true
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.barStyle = .black

        let backBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.backBarButtonItem = backBarButton
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
    }
}
