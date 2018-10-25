//
//  ImageAndTextView.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 25/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

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
