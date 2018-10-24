//
//  App+Listable.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation

extension App: Listable {
    public var text: String {
        return name
    }

    public var longText: String {
        return summary
    }

    public var imageUrl: String {
        return thumbImageUrl
    }
}
