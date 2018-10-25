//
//  ImageAndTextTableViewCell.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class ImageAndTextTableViewCell: UITableViewCell {

    // MARK: - Variables

    let layout = ImageAndTextView()

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

        // Necessary only in playgrounds
        //anchor(view: contentView)
        
        contentView.addSubview(layout)
        contentView.anchor(view: layout)
    }
}
