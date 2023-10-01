//
//  RemoteDataSource.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation

class RemoteDataSource: InvoiceRepository {
    //do an actual API call for the list of invoices or look in the local DB
    func getInvoiceList() -> [Invoice] {
        return [
            Invoice(
                dueAmount: 10.2,
                dueDate: Date(),
                providerUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Telekom_Logo_2013.svg/2560px-Telekom_Logo_2013.svg.png",
                locationName: "Acasa",
                locationIcon:"https://cdn-icons-png.flaticon.com/512/25/25694.png"
            ),
            Invoice(
                dueAmount: 20.42,
                dueDate: Date(),
                providerUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Telekom_Logo_2013.svg/2560px-Telekom_Logo_2013.svg.png",
                locationName: "Buni <3",
                locationIcon:"https://cdn-icons-png.flaticon.com/512/25/25694.png"
           ),
            Invoice(
                dueAmount: 100.5,
                dueDate: Date(),
                providerUrl: "https://newspascani.com/wp-content/uploads/2019/12/Logo-Enel.png",
                locationName: "Brasov",
                locationIcon:"https://cdn-icons-png.flaticon.com/512/25/25694.png"
            ),
            Invoice(
                dueAmount: 100.5,
                dueDate: Date(),
                providerUrl: "https://newspascani.com/wp-content/uploads/2019/12/Logo-Enel.png",
                locationName: "Pantelimon",
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
