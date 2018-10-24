import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

let appsViewController = AppsViewController()

let ressource = AppStoreRessource()

ressource.getTopApps(top: 100) { apps, _ in
    //
    print(apps)
    appsViewController.list = apps
}

PlaygroundPage.current.liveView = appsViewController
