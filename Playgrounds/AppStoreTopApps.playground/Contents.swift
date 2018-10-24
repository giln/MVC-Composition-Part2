import PlaygroundSupport
import UIKit

@testable import AppStoreFramework

public class ImageAndTextTableViewCell: UITableViewCell {
    // MARK: - Variables

    let stackView = UIStackView()
    let label = UILabel()
    let rightImageView = UIImageView()

    // MARK: - Lifecycle

    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

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

        // Necessary only in playgrounds
        anchor(view: contentView)

        contentView.addSubview(stackView)

        contentView.anchor(view: stackView)

        rightImageView.constrain(to: CGSize(width: 50, height: 50))
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

public protocol Listable {
    var text: String { get }
    var longText: String { get }
    var thumbImageUrl: String { get }
}

class AppsViewController: UITableViewController {
    public var list = [Listable]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ImageAndTextTableViewCell.self, forCellReuseIdentifier: ImageAndTextTableViewCell.defaultReuseIdentifier)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTextTableViewCell.defaultReuseIdentifier, for: indexPath)

        let element = list[indexPath.row]

        if let imageCell = cell as? ImageAndTextTableViewCell, let url = URL(string: element.thumbImageUrl) {
            imageCell.label.text = element.text
            URLSession.shared.dataTask(with: url) { data, _, _ in

                guard let data = data else { return }

                DispatchQueue.main.async {
                    imageCell.label.text = element.text

                    let image = UIImage(data: data)

                imageCell.rightImageView.image = image

                   }
            }.resume()
        }

        return cell
    }
}

let appsViewController = AppsViewController()

let ressource = AppStoreRessource()

ressource.getTopApps(top: 100) { apps, _ in
    //
    print(apps)
    appsViewController.list = apps
}

PlaygroundPage.current.liveView = appsViewController

// appsViewController.list = [app]
