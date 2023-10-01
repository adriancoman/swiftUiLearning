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
    
    var isInvoiceListEmpty: Bool {
        return invoiceList.isEmpty
    }
    
    init(repository: InvoiceRepository) {
        self.repository = repository
       
    }
    
    var haveDueAmount: Bool {
        return totalAmountToPay > 0.0
    }
    
    func downloadInvoiceList() {
        self.invoiceList = repository.getInvoiceList()
    }
    
    func toggleInvoiceSelection(at index: Int) {
        if (invoiceList.isEmpty) {
            return
        }
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
