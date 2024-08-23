//
//  DataProvider.swift
//  iOS Exmaple
//
//  Created by Apple on 22/08/24.
//

import Foundation


protocol DataProvider {
    func getData() async -> Result<[EData], Error>
}
