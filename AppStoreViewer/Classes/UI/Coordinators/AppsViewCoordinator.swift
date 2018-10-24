//
//  AppsViewCoordinator.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class AppsViewCoordinator: UIViewController {

    // MARK: - Variables
    private let appsViewController = ListViewController()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        add(asChildViewController: appsViewController)

        let ressource = AppStoreRessource()

        ressource.getTopApps(top: 100) { apps, _ in
            //
            self.appsViewController.list = apps
        }

    }

}
