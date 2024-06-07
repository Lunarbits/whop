//
//  ContentViewModel.swift
//  Whop
//
//  Created by Gregory Sapienza on 6/7/24.
//

import Foundation

struct ContentViewModel {
    var rows: [RowViewModel]
}

struct RowViewModel: Identifiable {
    let id = UUID()
    let title: String
    let url: URL?
    let children: [RowViewModel]?

    static func == (lhs: RowViewModel, rhs: RowViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
