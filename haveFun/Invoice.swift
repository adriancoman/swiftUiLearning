//
//  Invoice.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import SwiftUI

struct Invoice: Identifiable {
    let id = UUID()
    let dueAmount: Double
    let dueDate: Date
    let providerUrl: String
    let locationName: String
    let locationIcon: String
    var isChecked: Bool = false
}
