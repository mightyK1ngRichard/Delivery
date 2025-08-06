//
// Created by Dmitriy Permyakov on 06.08.2025.
// Copyright © 2025 Delivery24. All rights reserved.
//

import DLCore

public protocol AnyCategoryService: Cachable {
    func categoryProducts(categoryID: Int) async throws -> [CategoryProductEntity]
    func categories() async throws -> [CategoryEntity]
    func forceFetchCategories() async throws -> [CategoryEntity]
    func forceFetchCategoryProducts(categoryID: Int) async throws -> [CategoryProductEntity]
}
