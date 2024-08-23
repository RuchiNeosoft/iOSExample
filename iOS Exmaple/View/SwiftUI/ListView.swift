//
//  ListView.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import SwiftUI

struct ListView: View {
    let data: [EDataChild]
    @State private var searchText: String = ""
    private var filteredData: [EDataChild] {
        if searchText.isEmpty {
            return data
        } else {
            return data.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            TextField("Search", text: $searchText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            List(filteredData) { childData in
                ListRowView(data: childData)
                    .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(data: [.preview])
    }
}
