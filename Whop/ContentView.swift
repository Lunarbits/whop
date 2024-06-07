//
//  ContentView.swift
//  Whop
//
//  Created by Gregory Sapienza on 6/7/24.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @StateObject var logicController = ContentLogicController()

    var body: some View {
        NavigationStack {
            List(logicController.viewModel.rows, children: \.children) { row in
                RowView(viewModel: row)
                    .onAppear {
                        if row.id == logicController.viewModel.rows.last?.id {
                            logicController.loadMoreData()
                        }
                    }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Content")
        }
    }
}

struct RowView: View {
    let viewModel: RowViewModel

    var body: some View {
        if let url = viewModel.url {
            NavigationLink {
                WebView(url: url)
                    .navigationTitle(url.absoluteString)
            } label: {
                HStack {
                    Text(viewModel.title)
                    Spacer()
                    Image(systemName: "link")
                }
            }
        } else {
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
