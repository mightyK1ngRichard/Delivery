//
//  Created by Dmitriy Permyakov on 13.06.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import DLCore
import SwiftUI
import DesignSystem
import SharedUserStories

extension MainScreenView {

    var mainContainer: some View {
        stateView
            .basicToolBarItems(
                addressTitle: state.addressTitle,
                balance: state.balance,
                addressHandler: output.onTapSelectAddress
            )
            .alert(state.alertModel, showAlert: $state.showAlert)
            .preferredColorScheme(.light)
            .refreshable {
                await output.refresh()
            }
            .toolbar {
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
        ForEach(state.sections, id: \.section) { item in
            productSectionBlock(section: item.section, products: item.products) {
                output.onTapSectionLookMore(section: item.section)
            }
            .id("scroll_section_id_\(item.section.id)")
        }
    }
}

// MARK: - Section Views

extension MainScreenView {

    func productSectionBlock(
        section: ProductSection,
        products: [ProductModel],
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
    func sectionProducts(section: ProductSection, products: [ProductModel]) -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 8) {
                ForEach(products) { product in
                    productCard(for: product, section: section)
                        .frame(width: 168, height: 338)
                        .onTapGesture {
                            output.onTapProductCard(product: product)
                        }
                }
            }
            .padding(.horizontal)
        }
        .scrollIndicators(.hidden)
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

    func productCard(for product: ProductModel, section: ProductSection) -> some View {
        DProductCard(
            product: state.factory.convertToDProductCard(from: product),
            handler: .init(
                didTapLike: { isLike in
                    output.onTapLike(id: product.id, isLike: isLike)
                },
                didTapPlus: { counter in
                    output.onTapPlusInBasket(
                        product: product,
                        counter: counter,
                        coeff: product.magnifier,
                        section: section
                    )
                },
                didTapMinus: { counter in
                    output.onTapMinusInBasket(
                        product: product,
                        counter: counter,
                        coeff: product.magnifier,
                        section: section
                    )
                },
                didTapBasket: { startCounter in
                    output.onTapAddInBasket(
                        product: product,
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
        
        static let popularCategoriesSectionTitle = "Популярные Категории"
        static let lookMoreTitle = "См. все"
        static let textPrimary = DLColor<TextPalette>.primary.color
        static let lookMoreColor = DLColor<TextPalette>.darkBlue.color
        static let scrollTopID = "SCROLL_TOP_ID"
    }
}
