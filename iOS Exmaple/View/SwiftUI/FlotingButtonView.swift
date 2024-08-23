//
//  FlotingButtonView.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import Foundation
import SwiftUI

struct FlotingButtonView: View {
    let data: [EDataChild]
    @State private var showBottomSheet = false
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    showBottomSheet.toggle()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding()
                }
            }
        }
        .sheet(isPresented: $showBottomSheet) {
            BottomSheetView(data: data)
        }
    }
}

struct FlotingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FlotingButtonView(data: [.preview])
    }
}

