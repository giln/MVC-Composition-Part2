import UIKit
import PlaygroundSupport

@testable import AppStoreFramework



public protocol Listable {
    var text: String { get }
    var longText: String { get }
}

class AppsViewController: UITableViewController {

    public var list = [Listable]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Default")

    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Default", for: indexPath)

        let element = list[indexPath.row]

        cell.textLabel?.text = element.text

        return cell
    }
}

extension App: Listable {
    public var text: String {
        return name
    }

    public var longText: String {
        return summary
    }
}

let appsViewController = AppsViewController()

let ressource = AppStoreRessource()

ressource.getTopApps(top: 10) { (apps, error) in
    //
    print(apps)
    appsViewController.list = apps
}

PlaygroundPage.current.liveView = appsViewController


