import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

public class AppsViewCoordinator: UIViewController {

    // MARK: - Variables
    private let appsViewController = AppsViewController()

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

PlaygroundPage.current.liveView = AppsViewCoordinator()
