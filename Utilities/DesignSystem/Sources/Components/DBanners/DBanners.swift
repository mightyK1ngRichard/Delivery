//
// DBanners.swift
// iOS-Delivery24
//
// Created by Garbuzov Matvey on 24.06.2024
// Copyright © 2024 Dostavka24. All rights reserved.
//

import SwiftUI

public struct BannerPage: Identifiable, Equatable, Sendable {

    public var id: UUID
    let backID: Int
    var url: URL?

    public init(id: UUID = UUID(), backID: Int, url: URL? = nil) {
        self.id = id
        self.backID = backID
        self.url = url
    }
}

public struct DBanners: View {

    @State var pages: [BannerPage] = []
    @State private var fakePages: [BannerPage] = []
    @State private var currentPage = ""

    public init(pages: [BannerPage]) {
        self._pages = State(initialValue: pages)
    }

    public var body: some View {
        GeometryReader {
            let size = $0.size

            TabView(selection: $currentPage) {
                ForEach(fakePages) { page in
                    CarouselItem(page.url)
                        .tag(page.id.uuidString)
                        .offsetX(currentPage == page.id.uuidString) { rect in
                            let minX = rect.minX
                            let pageOffset = minX - (size.width * CGFloat(fakeIndexOf(page)))

                            let pageProgress = pageOffset / size.width

                            if -pageProgress < 1.0 {
                                if fakePages.indices.contains(fakePages.count - 1) {
                                    currentPage = fakePages[fakePages.count - 1].id.uuidString
                                }
                            }

                            if -pageProgress > CGFloat(fakePages.count - 1) {
                                if fakePages.indices.contains(1) {
                                    currentPage = fakePages[1].id.uuidString
                                }
                            }
                        }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: size.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            guard fakePages.isEmpty else { return }
            fakePages.append(contentsOf: pages)

            if var firstImage = pages.first, var lastImage = pages.last {
                currentPage = firstImage.id.uuidString

                firstImage.id = .init()
                lastImage.id = .init()

                fakePages.append(firstImage)
                fakePages.insert(lastImage, at: 0)
            }
        }
    }

    func fakeIndexOf(_ page: BannerPage) -> Int {
        fakePages.firstIndex { $0 == page } ?? 0
    }
}

extension DBanners {

    func CarouselItem(_ url: URL?) -> some View {
        ZStack {
            Rectangle()
                .fill(.thinMaterial)

            DLImageView(
                configuration: .init(
                    imageKind: .url(url)
                )
            )
        }
        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
        .padding(.horizontal)
    }
}
