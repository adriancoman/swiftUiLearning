//
//  InvoiceRepository.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation

protocol InvoiceRepository {
    func getInvoiceList() -> [Invoice]
}
