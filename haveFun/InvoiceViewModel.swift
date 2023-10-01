//
//  InvoiceViewModel.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation

class InvoiceViewModel: ObservableObject {
    @Published var invoiceList: [Invoice] = [
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
       
    @Published var totalAmountToPay: Double = 0.0
    @Published var selectAll: Bool = false
    
    func toggleInvoiceSelection(at index: Int) {
        invoiceList[index].isChecked.toggle()
        if invoiceList[index].isChecked {
            totalAmountToPay += invoiceList[index].dueAmount
        } else {
            totalAmountToPay -= invoiceList[index].dueAmount
        }
    }
    
    func toggleSelectAll() {
        selectAll.toggle()
        if selectAll {
            totalAmountToPay = invoiceList.map { $0.dueAmount }.reduce(0, +)
            for index in invoiceList.indices {
                invoiceList[index].isChecked = true
            }
        } else {
            totalAmountToPay = 0.0
            for index in invoiceList.indices {
                invoiceList[index].isChecked = false
            }
        }
    }
}
