//
//  InvoiceViewModel.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation

class InvoiceViewModel: ObservableObject {
    
    private var repository: InvoiceRepository
    
    @Published var invoiceList: [Invoice] = []
    @Published var totalAmountToPay: Double = 0.0
    @Published var selectAll: Bool = false
    
    init(repository: InvoiceRepository) {
        self.repository = repository
        self.invoiceList = repository.getInvoiceList()
    }
    
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
