//
//  Created by Dmitriy Permyakov on 26.08.2024
//  Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI
import DesignSystem

struct CategoryListScreenView: View {

    @StateObject
    var state: CategoryListScreenViewState
    let output: CategoryListScreenViewOuput

    var body: some View {
        mainContainer.onFirstAppear {
            output.onFirstAppear()
        }
    }
}

// MARK: - UI Subviews

private extension CategoryListScreenView {

    var mainContainer: some View {
        ScrollView {
            switch state.state {
            case .loading:
                ProgressView()
            case .error:
                ErrorView(title: "Ошибка получения данных", handler: output.onTapReloadButton)
            case .content:
                content
            }
        }
        .searchable(
            text: $state.searchText,
            placement: .navigationBarDrawer(displayMode: .always)
        )
        .navigationTitle(state.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }

    var content: some View {
        VStack(spacing: 0) {
            ForEach(state.filteredCategoryCells) { category in
                Button {
                    output.onTapCategoryCell(category: category)
                } label: {
                    cellView(title: category.title)
                }
                .overlay(alignment: .bottom) {
                    Divider()
                }
            }
        }
        .padding(.leading)
        .padding(.top, .SPx6)
    }

    func cellView(title: String) -> some View {
        HStack(spacing: .SPx4) {
            Text(title)
                .style(size: 17, weight: .regular, color: Constants.textPrimary)
                .multilineTextAlignment(.leading)
            Spacer()
            DLIcon.chivronRight.image
                .renderingMode(.template)
                .foregroundStyle(Constants.chivronColor)
                .frame(width: 44, height: 44)
        }
    }
}

// MARK: - Constants

private extension CategoryListScreenView {

    enum Constants {

        static let textPrimary = DLColor<TextPalette>.primary.color
        static let chivronColor = DLColor<IconPalette>.secondary.color
    }
}
