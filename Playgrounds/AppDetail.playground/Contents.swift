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

    private let titleLabel = UILabel()
    private let longLabel = UILabel()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()


    // MARK: - Lifecyle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill

        scrollView.addSubview(stackView)
        // Use safe anchors = false
        scrollView.anchor(view: stackView, useSafeAnchors: false)

        view.addSubview(scrollView)

        anchor(view: scrollView)

       // Contrainte supplémentaire pour scroller verticalement uniquement
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        longLabel.numberOfLines = 0
        stackView.addArrangedSubview(titleLabel)

        stackView.addArrangedSubview(longLabel)
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
