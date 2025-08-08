//
//  Created by Dmitriy Permyakov on 07.08.2025.
//  Copyright © 2025 Delivery24. All rights reserved.
//

import SwiftUI
import DLCore

public struct DTagsSection: View {

    let sections: [Section]

    @Binding
    var lastSelectedItem: String?

    public init(sections: [Section], lastSelectedItem: Binding<String?>) {
        self.sections = sections
        self._lastSelectedItem = lastSelectedItem
    }

    @State
    private var lastSelectedItemHScroll: String?

    public var body: some View {
        ScrollView(.horizontal) {
            ScrollViewReader { reader in
                HStack(spacing: .SPx2) {
                    ForEach(sections) { section in
                        DTag(
                            iconKind: section.kind.iconKind,
                            title: section.title.capitalizingFirstLetter
                        )
                        .id("scroll_h_id_\(section.id)")
                        .onTapGesture {
                            lastSelectedItem = "scroll_section_id_\(section.id)"
                            lastSelectedItemHScroll = String(section.id)
                        }
                    }
                }
                .padding(.horizontal)
                .onChange(of: lastSelectedItemHScroll) { id in
                    guard let id else { return }
                    withAnimation {
                        reader.scrollTo("scroll_h_id_\(id)", anchor: .center)
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .padding(.top, .SPx2)
        .padding(.bottom, .SPx3)
    }
}

// MARK: - Section

extension DTagsSection {

    public struct Section: Identifiable, Hashable {

        public let id: Int
        let title: String
        let kind: Kind

        public init(id: Int, title: String, kind: Kind) {
            self.id = id
            self.title = title
            self.kind = kind
        }

        public enum Kind: Hashable {
            case actions
            case exclusives
            case news
            case hits
        }
    }
}

extension DTagsSection.Section.Kind {

    var iconKind: DTag.IconKind {
        switch self {
        case .actions:
            return .discount
        case .exclusives:
            return .clear
        case .news:
            return .new
        case .hits:
            return .hits
        }
    }
}
