//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation

protocol AnyMediaFactory {
    func convertImageURL(from urlString: String) -> URL?
}

struct MediaFactory: AnyMediaFactory {

    func convertImageURL(from urlString: String) -> URL? {
        URL(string: "https://www.dostavka24.net/upload/\(urlString)")
    }
}
