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

    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter
    }()

    private let priceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₽"
        formatter.groupingSeparator = " "
        formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()

    func convertToDProductCard(from model: Product) -> DProductCardModel {
        .init(
            id: model.id,
            imageURL: URL(string: model.imageURL),
            title: model.title,
            price: model.formattedPrice,
            description: model.description,
            startCounter: model.startCounter,
            magnifier: model.magnifier,
            tags: model.tags.map(convertToTags)
        )
    }

    func convertToProduct(from entity: ProductEntity) -> Product? {
        guard let id = entity.id,
              let image = entity.image,
              let priceItem = entity.priceItem,
              let description = entity.description,
              let formattedExpirationDate = calculateExpirationDate(from: entity.expirationDate),
              let brandEntity = entity.brand,
              let brand = convertToBrand(from: brandEntity),
              let cashback = entity.cashback,
              let packageCount = entity.kolvoUpak,
              let formattedPrice = convertToPrice(from: priceItem)
        else { return nil }

        return .init(
            id: id,
            imageURL: convertImageURL(from: image),
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

    func covertToTagSection(from model: ProductSection) -> DTagsSection.Section {
        switch model {
        case .actions:
            return .init(id: model.id, title: model.title, kind: .actions)
        case .exclusives:
            return .init(id: model.id, title: model.title, kind: .exclusives)
        case .news:
            return .init(id: model.id, title: model.title, kind: .news)
        case .hits:
            return .init(id: model.id, title: model.title, kind: .hits)
        }
    }

    func convertToPopcat(from entity: PopcatsEntity) -> Popcat? {
        guard let id = entity.id,
              let title = entity.title,
              let urlString = entity.image,
              let imageURL = URL(string: convertImageURL(from: urlString))
        else { return nil }

        return .init(id: id, title: title, imageURL: imageURL)
    }

    func convertToBannerPage(from entity: BannerEntity) -> BannerPage? {
        guard let id = entity.id,
              let imageURLString = entity.image,
              let url = URL(string: convertImageURL(from: imageURLString))
        else { return nil }

        return BannerPage(backID: id, url: url)
    }

    func convertToDCategoryModel(from model: Popcat) -> DCategoryModel {
        DCategoryModel(id: model.id, imageURL: model.imageURL, title: model.title)
    }
}

// MARK: - Private

extension MainScreenFactory {

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

    private func convertToPrice(from priceItemString: String?) -> String? {
        guard let priceItemString,
              let priceItem = Double(priceItemString),
              let formattedString = priceFormatter.string(from: NSNumber(value: priceItem))
        else { return nil }

        return formattedString
    }

    private func convertImageURL(from urlString: String) -> String {
        "https://www.dostavka24.net/upload/\(urlString)"
    }

    private func convertToBrand(from entity: ProductEntity.Brand) -> Product.Brand? {
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

    private func calculateExpirationDate(from expirationDate: String?) -> String? {
        guard let daysInt = Int(expirationDate ?? String()) else {
            return nil
        }

        let currentDate = Date()
        var dateComponent = DateComponents()
        dateComponent.day = daysInt
        let calendar = Calendar.current

        guard let futureDate = calendar.date(byAdding: dateComponent, to: currentDate) else {
            return "\(daysInt) дн."
        }

        let formattedDate = dateFormatter.string(from: futureDate)
        return "\(daysInt) дн. (до \(formattedDate))"
    }
}
