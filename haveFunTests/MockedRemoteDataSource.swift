//
//  MockedRemoteDataSource.swift
//  haveFunTests
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation

@testable import haveFun

class MockedDataSource: InvoiceRepository {
    
    func getInvoiceList() -> [Invoice] {
        return [
            Invoice(
                dueAmount: 10,
                dueDate: Date(),
                providerUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Telekom_Logo_2013.svg/2560px-Telekom_Logo_2013.svg.png",
                locationName: "Acasa",
                locationIcon:"https://cdn-icons-png.flaticon.com/512/25/25694.png"
            ),
            Invoice(
                dueAmount: 100.5,
                dueDate: Date(),
                providerUrl: "https://static.wikia.nocookie.net/logopedia/images/f/ff/Digi_RCSRDS.svg/revision/latest/scale-to-width-down/250?cb=20220908200103",
                locationName: "Pantelimon",
                locationIcon:"https://cdn-icons-png.flaticon.com/512/25/25694.png"
            ),
        ]
    }
}
