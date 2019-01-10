//
//  LoadingViewController.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 07/01/2019.
//  Copyright © 2019 Viseo. All rights reserved.
//

import UIKit

public class LoadingViewController: UIViewController {
    // MARK: - Variables

    private let contentViewController: UIViewController
    private let activityIndicator = UIActivityIndicatorView(style: .gray)

    // MARK: - Init

    init(contentViewController: UIViewController) {
        self.contentViewController = contentViewController
        super.init(nibName: nil, bundle: nil)
    }

    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        activityIndicator.hidesWhenStopped = true

        add(asChildViewController: contentViewController)

        view.addSubview(activityIndicator)

        activityIndicator.center(in: view)
    }

    // MARK: - Public functions

    public func startLoading() {
        contentViewController.view.isHidden = true
        activityIndicator.startAnimating()
    }

    public func endLoading() {
        activityIndicator.stopAnimating()
        contentViewController.view.isHidden = false
    }
}
