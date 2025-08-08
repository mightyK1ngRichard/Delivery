//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import DLCore
import SwiftUI
import DesignSystem

extension MainScreenView {

    var mainContainer: some View {
        stateView
            .preferredColorScheme(.light)
            .bindSize($state.size)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: output.onTapSelectAddress) {
                        addressView
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if let moneyCount = state.balance {
                        WalletView(moneyCount: moneyCount)
                    }
                }
                ToolbarItem(placement: .keyboard) {
                    Button("Отмена") {
                        isFocused = false
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
    }
}

private extension MainScreenView {

    @ViewBuilder
    var stateView: some View {
        switch state.screenState {
        case .loading:
            StartLoadingView()
        case .content:
            content
        case .error:
            ErrorView(title: "Ошибка получения данных", handler: output.onTapReload)
        }
    }

    var closeSheetButton: some View {
        Button {
            state.showAddressView = false
        } label: {
            Image(systemName: "xmark")
                .renderingMode(.template)
                .foregroundStyle(DLColor<IconPalette>.primary.color)
        }
    }

    var content: some View {
        ScrollView {
            ScrollViewReader { scrollViewProxy in
                VStack(spacing: 0) {
                    MainHeaderView(
                        textInput: $state.searchText
                    )
                    .focused($isFocused)

                    tagsSection
                        .padding(.top, 13)

                    VStack(spacing: 32) {
                        bannerSection
                        productSections
                    }
                    .padding(.top)

                    popularCategoriesSection
                        .padding(.top, 32)
                }
                .onChange(of: state.lastSelectedSection) { newValue in
                    guard let id = newValue else { return }
                    withAnimation {
                        scrollViewProxy.scrollTo(id, anchor: .top)
                    }
                }
            }
        }
    }
}

// MARK: - Navigation Bar

extension MainScreenView {

    var addressView: some View {
        HStack(spacing: 4) {
            Text(state.addressTitle ?? Constants.addressTitle)
                .style(size: 11, weight: .semibold, color: Constants.textPrimary)

            DLIcon.bottomChevron.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
        }
    }
}

// MARK: - Assembling Sections

extension MainScreenView {

    var tagsSection: some View {
        DTagsSection(
            sections: state.tags,
            lastSelectedItem: $state.lastSelectedSection
        )
    }

    var bannerSection: some View {
        DBanners(pages: state.banners)
            .frame(height: 180)
    }

    @ViewBuilder
    var productSections: some View {
        ForEach(state.sections, id: \.section) { (section, products) in
            productSectionBlock(
                section: section,
                products: products
            ) {
                output.onTapSectionLookMore(section: section)
            }
            .id("scroll_section_id_\(section.id)")
        }
    }
}

// MARK: - Section Views

extension MainScreenView {

    func productSectionBlock(
        section: ProductSection,
        products: [Product],
        action: @escaping DLVoidBlock
    ) -> some View {
        VStack(spacing: 8) {
            sectionTitleView(title: section.title.capitalized, action: action)
            sectionProducts(section: section, products: products)
        }
    }

    func sectionTitleView(title: String, action: @escaping DLVoidBlock) -> some View {
        HStack {
            Text(title)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)
            Spacer()
            Button(action: action, label: {
                Text(Constants.lookMoreTitle)
                    .style(size: 17, weight: .regular, color: Constants.lookMoreColor)
            })
        }
        .padding(.horizontal)
    }

    @ViewBuilder
    func sectionProducts(section: ProductSection, products: [Product]) -> some View {
        let size = state.size
        let cardWidth = size.width < size.height ? size.width / 2.23 : size.height / 2.23
        let cardHeight = size.width < size.height ? cardWidth * 2.01 : size.height / 1.5

        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
                ForEach(products) { product in
                    productCard(for: product, section: section)
                        .frame(width: cardWidth, height: cardHeight)
                        .onTapGesture {
                            output.onTapProductCard(product: product)
                        }
                }
            }
            .padding(.horizontal)
        }
    }

    var popularCategoriesSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.popularCategoriesSectionTitle)
                .style(size: 22, weight: .bold, color: Constants.textPrimary)

            LazyVGrid(
                columns: Array(repeating: GridItem(spacing: 8), count: 2),
                spacing: 8
            ) {
                ForEach(state.popcats) { popcat in
                    DCategory(category: state.factory.convertToDCategoryModel(from: popcat))
                        .onTapGesture {
                            output.onTapPopcatsCell(
                                id: popcat.id,
                                title: popcat.title
                            )
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - DS Views

extension MainScreenView {

    func productCard(for product: Product, section: ProductSection) -> some View {
        DProductCard(
            product: state.factory.convertToDProductCard(from: product),
            handler: .init(
                didTapLike: { isLike in
                    output.onTapLike(id: product.id, isLike: isLike)
                },
                didTapPlus: { counter in
                    output.onTapPlusInBasket(
                        productID: product.id,
                        counter: counter,
                        coeff: product.magnifier,
                        section: section
                    )
                },
                didTapMinus: { counter in
                    output.onTapMinusInBasket(
                        productID: product.id,
                        counter: counter,
                        coeff: product.magnifier,
                        section: section
                    )
                },
                didTapBasket: { startCounter in
                    output.onTapAddInBasket(
                        id: product.id,
                        counter: startCounter,
                        coeff: product.magnifier,
                        section: section
                    )
                }
            )
        )
        .contentShape(.rect)
    }
}

// MARK: - Constants

private extension MainScreenView {

    enum Constants {
        static let addressTitle = String(localized: "specify_the_delivery_address").capitalizingFirstLetter
        static let popularCategoriesSectionTitle = String(localized: "popular_categories").capitalized
        static let lookMoreTitle = String(localized: "look_more").capitalizingFirstLetter
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let lookMoreColor = DLColor<TextPalette>.darkBlue.color
        static let scrollTopID = "SCROLL_TOP_ID"
    }
}
