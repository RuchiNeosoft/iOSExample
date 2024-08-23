//
//  ViewModel.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//


import Foundation

class ViewModel: ObservableObject {
    private let provider: DataProvider
    @Published @MainActor var data: [EData] = .init()

    init(withDataProvider dataProvider: DataProvider) {
        provider = dataProvider
    }

    @MainActor
    func getData() async throws {
        data = try await provider.getData().get()
    }
}
