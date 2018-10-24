import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

public class DetailViewController: UIViewController {
    // MARK: - Public Variables

    public var detail: Listable? {
        didSet {
            titleLabel.text = detail?.text
            longLabel.text = detail?.longText
        }
    }

    // MARK: - Private Variables

    private var titleLabel = UILabel()
    private var longLabel = UILabel()
    private var stackView = UIStackView()

    // MARK: - Lifecyle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView.axis = .vertical
        stackView.alignment = .fill

        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(longLabel)
        anchor(view: stackView)
    }
}

public class AppsViewCoordinator1: UIViewController, UITableViewDelegate {
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

let appsCoordinator = AppsViewCoordinator1()

PlaygroundPage.current.liveView = appsCoordinator
