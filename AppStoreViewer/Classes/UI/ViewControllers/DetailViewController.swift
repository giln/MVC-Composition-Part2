//
//  DetailViewController.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 25/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

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
