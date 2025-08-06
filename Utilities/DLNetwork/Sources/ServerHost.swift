//
// Created by Dmitriy Permyakov on 05.08.2025
// Copyright © 2025 Dostavka24. All rights reserved.
//

import Foundation

public enum ServerHost: String {
    case production = "https://www.dostavka24.net/api"

    public var url: URL {
        URL(string: rawValue)!
    }
}
