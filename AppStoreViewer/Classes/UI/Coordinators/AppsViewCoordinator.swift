//
//  AppsViewCoordinator.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class AppsViewCoordinator: UIViewController, UITableViewDelegate {
    // MARK: - Variables

    private let appsViewController = ListViewController()

    private lazy var navController = UINavigationController(rootViewController: appsViewController)

    private var apps = [App]()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        appsViewController.tableView.delegate = self

        add(asChildViewController: navController)

        let ressource = AppStoreRessource()

        ressource.getTopApps(top: 100) { apps, _ in
            //
            self.apps = apps
            self.appsViewController.list = apps
        }
    }

    // MARK: - UITableViewDelegate

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()

        let detail = apps[indexPath.row]

        detailViewController.detail = detail
        navController.pushViewController(detailViewController, animated: true)
    }
}
