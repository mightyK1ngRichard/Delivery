//
//  Created by Dmitriy Permyakov on 09.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import Foundation
import SharedContractsInterface
import DesignSystem
import CatalogServiceInterface

public protocol AnyProductFactory: Sendable {
    // MARK: DTO -> Model
    func convertToProduct(from entity: ProductEntity) -> ProductModel?
    func convertToProduct(from entity: CategoryProductEntity) -> ProductModel?
    // MARK: Model -> DSModel
    func convertToDProductCard(from model: ProductModel) -> DProductCardModel
    func covertToTagSection(from model: ProductSection) -> DTagsSection.Section
}

public struct ProductFactory: AnyProductFactory {

    let priceFactory: AnyPriceFactory
    let dateFactory: AnyDateFactory
    let mediaFactory: AnyMediaFactory

    public init(
        priceFactory: AnyPriceFactory,
        dateFactory: AnyDateFactory,
        mediaFactory: AnyMediaFactory
    ) {
        self.priceFactory = priceFactory
        self.dateFactory = dateFactory
        self.mediaFactory = mediaFactory
    }

    public func convertToProduct(from entity: CategoryProductEntity) -> ProductModel? {
        guard let id = entity.id,
              let image = entity.image,
              let priceItem = entity.priceItem,
              let description = entity.description,
              let formattedExpirationDate = dateFactory.calculateExpirationDate(from: entity.expirationDate),
              let brandEntity = entity.brand,
              let brand = convertToBrand(from: brandEntity),
              let cashback = entity.cashback,
              let packageCount = entity.kolvoUpak,
              let formattedPrice = priceFactory.convertToPrice(from: priceItem)
        else { return nil }

        return .init(
            id: id,
            imageURL: mediaFactory.convertImageURL(from: image),
            title: entity.title ?? "Без заголовка",
            formattedPrice: formattedPrice,
            description: description,
            startCounter: entity.coeff ?? 0,
            magnifier: entity.coeff ?? 1,
            tags: productTags(from: entity),
            brand: brand,
            cashback: String(cashback),
            packageCount: .init(count: packageCount, formattedCountTile: "\(packageCount) шт."),
            formattedExpirationDate: formattedExpirationDate
        )
    }

    public func convertToProduct(from entity: ProductEntity) -> ProductModel? {
        guard let id = entity.id,
              let image = entity.image,
              let priceItem = entity.priceItem,
              let description = entity.description,
              let formattedExpirationDate = dateFactory.calculateExpirationDate(from: entity.expirationDate),
              let brandEntity = entity.brand,
              let brand = convertToBrand(from: brandEntity),
              let cashback = entity.cashback,
              let packageCount = entity.kolvoUpak,
              let formattedPrice = priceFactory.convertToPrice(from: priceItem)
        else { return nil }

        return .init(
            id: id,
            imageURL: mediaFactory.convertImageURL(from: image),
            title: entity.title ?? "Без заголовка",
            formattedPrice: formattedPrice,
            description: description,
            startCounter: entity.coeff ?? 0,
            magnifier: entity.coeff ?? 1,
            tags: productTags(from: entity),
            brand: brand,
            cashback: String(cashback),
            packageCount: .init(count: packageCount, formattedCountTile: "\(packageCount) шт."),
            formattedExpirationDate: formattedExpirationDate
        )
    }

    public func convertToDProductCard(from model: ProductModel) -> DProductCardModel {
        .init(
            id: model.id,
            imageURL: model.imageURL,
            title: model.title,
            price: model.formattedPrice,
            description: model.description,
            startCounter: model.startCounter,
            magnifier: model.magnifier,
            tags: model.tags.map(convertToTags)
        )
    }

    public func covertToTagSection(from model: ProductSection) -> DTagsSection.Section {
        .init(id: model.id, title: model.title, tags: convertToTags(from: model))
    }
}

// MARK: - Private

extension ProductFactory {

    // MARK: DTO -> Model

    private func convertToBrand(from entity: ProductEntity.Brand) -> ProductModel.Brand? {
        guard let id = entity.id, let title = entity.title else {
            return nil
        }

        return .init(id: id, title: title)
    }

    private func convertToBrand(from entity: CategoryProductEntity.Brand) -> ProductModel.Brand? {
        guard let id = entity.id, let title = entity.title else {
            return nil
        }

        return .init(id: id, title: title)
    }

    private func productTags(from entity: ProductEntity) -> [ProductSection] {
        Set([
            entity.hit == 1 ? ProductSection.hits : nil,
            entity.actionFlag == 1 ? ProductSection.actions : nil,
            entity.actionFlag2 == 1 ? ProductSection.actions : nil,
            entity.exclusFlag == 1 ? ProductSection.exclusives : nil,
        ]).compactMap { $0 }
    }

    private func productTags(from entity: CategoryProductEntity) -> [ProductSection] {
        Set([
            entity.hit == 1 ? ProductSection.hits : nil,
            entity.actionFlag == 1 ? ProductSection.actions : nil,
            entity.actionFlag2 == 1 ? ProductSection.actions : nil,
            entity.exclusFlag == 1 ? ProductSection.exclusives : nil,
        ]).compactMap { $0 }
    }

    // MARK: Model -> DSModel

    private func convertToTags(from model: ProductSection) -> Tags {
        switch model {
        case .actions:
            return .promotion
        case .exclusives:
            return .exclusive
        case .news:
            return .news
        case .hits:
            return .hit
        }
    }
}
