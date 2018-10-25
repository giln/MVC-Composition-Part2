import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

public class ImageAndTextView: UIView {
    // MARK: - Variables

    let stackView = UIStackView()
    let label = UILabel()
    let rightImageView = DownloadImageView()

    // MARK: - Lifecycle

    public override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        commonInit()
    }

    private func commonInit() {
        label.numberOfLines = 0

        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center

        stackView.spacing = 5

        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(rightImageView)

        addSubview(stackView)

        anchor(view: stackView)

        rightImageView.constrain(to: CGSize(width: 50, height: 50))
    }
}

public class DetailViewController: UIViewController {
    // MARK: - Public Variables

    public var detail: Listable? {
        didSet {
            imageAndTextView.label.text = detail?.text

            longLabel.text = detail?.longText

            guard let detail = detail,
                let url = URL(string: detail.imageUrl) else { return }
            imageAndTextView.rightImageView.url = url
        }
    }

    // MARK: - Private Variables

    private let longLabel = UILabel()
    private let stackView = UIStackView()
    private let scrollView = UIScrollView()

    private let imageAndTextView = ImageAndTextView()

    // MARK: - Lifecyle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.isLayoutMarginsRelativeArrangement = true

        scrollView.addSubview(stackView)
        // Use safe anchors = false
        scrollView.anchor(view: stackView, useSafeAnchors: false)

        view.addSubview(scrollView)

        anchor(view: scrollView)

        // Contrainte supplémentaire pour scroller verticalement uniquement
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        longLabel.numberOfLines = 0
        stackView.addArrangedSubview(imageAndTextView)

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
