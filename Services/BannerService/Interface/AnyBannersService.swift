//
//  Created by Dmitriy Permyakov on 06.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore

public protocol AnyBannersService: Cachable {
    var banners: [BannerEntity] { get async throws }
    func forceFetchBanners() async throws -> [BannerEntity]
}
