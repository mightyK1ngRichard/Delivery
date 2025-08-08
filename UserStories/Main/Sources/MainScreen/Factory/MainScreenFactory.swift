//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import DLCore
import DesignSystem
import SharedContractsInterface
import BannerServiceInterface
import PopcatsServiceInterface

struct MainScreenFactory: AnyMainScreenFactory {

    let mediaFactory: AnyMediaFactory
    let productFactory: AnyProductFactory

    func convertToProduct(from entity: ProductEntity) -> Product? {
        productFactory.convertToProduct(from: entity)
    }

    func convertToPopcat(from entity: PopcatsEntity) -> Popcat? {
        guard let id = entity.id,
              let title = entity.title,
              let urlString = entity.image,
              let imageURL = mediaFactory.convertImageURL(from: urlString)
        else { return nil }

        return .init(id: id, title: title, imageURL: imageURL)
    }

    func convertToBannerPage(from entity: BannerEntity) -> BannerPage? {
        guard let id = entity.id,
              let imageURLString = entity.image,
              let url = mediaFactory.convertImageURL(from: imageURLString)
        else { return nil }

        return BannerPage(backID: id, url: url)
    }

    func convertToDCategoryModel(from model: Popcat) -> DCategoryModel {
        DCategoryModel(id: model.id, imageURL: model.imageURL, title: model.title)
    }

    func convertToDProductCard(from model: Product) -> DProductCardModel {
        productFactory.convertToDProductCard(from: model)
    }

    func covertToTagSection(from model: ProductSection) -> DTagsSection.Section {
        productFactory.covertToTagSection(from: model)
    }
}
