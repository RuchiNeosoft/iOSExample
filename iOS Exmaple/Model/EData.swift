//
//  EData.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import UIKit

struct EData {
    let mainImage: String
    let listItems: [EDataChild]
}

struct EDataChild: Identifiable, Hashable {
    let id = UUID()
    let image: String
    let name: String
    let detail: String
}

extension EDataChild {
    static let preview: EDataChild = .init(image: "TajMahal", name: "Taj Mahal", detail: "Agra")
}
