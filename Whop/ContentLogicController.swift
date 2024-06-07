//
//  ContentLogicController.swift
//  Whop
//
//  Created by Gregory Sapienza on 6/7/24.
//

import Foundation

@MainActor final class ContentLogicController: ObservableObject {
    @Published var viewModel: ContentViewModel = ContentViewModel(rows: [])
    private var allRows: [RowViewModel] = []
    private var currentIndex = 0
    private let itemsPerPage = 20

    init() {
        preloadData()
        loadMoreData()
    }

    func loadMoreData() {
        let endIndex = min(currentIndex + itemsPerPage, allRows.count)
        guard currentIndex < endIndex else { return }

        viewModel.rows.append(contentsOf: allRows[currentIndex..<endIndex])
        currentIndex = endIndex
    }

    private func preloadData() {
        for i in 0..<500 {
            if i % 2 == 0 {
                allRows.append(RowViewModel(title: "Web Row \(i)", url: URL(string: "https://google.com/"), children: nil))
            } else {
                allRows.append(
                    RowViewModel(title: "Folder Row \(i)",
                                 url: nil,
                                 children: [RowViewModel(title: "Child Row \(i)",
                                                         url: URL(string: "https://google.com/"), children: nil)])
                )
            }
        }
    }
}
