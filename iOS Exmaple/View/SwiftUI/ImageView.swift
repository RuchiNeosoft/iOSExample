//
//  ImageView.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import SwiftUI

struct ImageView: View {
    let imageName: String
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(imageName: "waterfalls")
    }
}
