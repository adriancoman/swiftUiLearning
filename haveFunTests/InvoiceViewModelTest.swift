//
//  InvoiceViewModelTest.swift
//  haveFunTests
//
//  Created by Adrian Coman on 01.10.2023.
//

import Foundation
import XCTest
@testable import haveFun

class InvoiceViewModelTest: XCTestCase {
    
    var viewModel: InvoiceViewModel!

    override func setUp() {
        super.setUp()
        viewModel = InvoiceViewModel(repository: MockedDataSource())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIsInvoiceListEmptyShouldReturnTrueWhenListIsEmpty() {
        let isEmpty = viewModel.isInvoiceListEmpty
        
        //check it's checked
        XCTAssertTrue(isEmpty)
    }
    
    func testIsInvoiceListEmptyShouldReturnFalseWhenListIsNotEmpty() {
        viewModel.downloadInvoiceList()
        let isEmpty = viewModel.isInvoiceListEmpty
        
        //check it's checked
        XCTAssertFalse(isEmpty)
    }
    
    func testToggleInvoiceSelectionShouldUpdateTheDueAmountWhenISelect() {
        viewModel.downloadInvoiceList()
        
        //10.2
        viewModel.toggleInvoiceSelection(at: 0)

        //check it's checked
        XCTAssertTrue(viewModel.invoiceList[0].isChecked)
        XCTAssertEqual(viewModel.totalAmountToPay, 10.0)

    }
    
    func testToggleInvoiceSelectionShouldUpdateTheDueAmountWhenISelectAndDeselect() {
        viewModel.downloadInvoiceList()
        //10.2
        viewModel.toggleInvoiceSelection(at: 0)
        viewModel.toggleInvoiceSelection(at: 0)
        
        //check it's checked
        XCTAssertFalse(viewModel.invoiceList[0].isChecked)
        XCTAssertEqual(viewModel.totalAmountToPay, 0)
    }
    
    func testSelectAllShouldDisplayTheCorrectValueWhenAllInvoicesAreSelected() {
        viewModel.downloadInvoiceList()
        viewModel.toggleSelectAll()
        
        for invoice in viewModel.invoiceList {
            XCTAssertTrue(invoice.isChecked)
        }
        
        XCTAssertEqual(viewModel.totalAmountToPay, 110.5)
    }
    
    func testSelectAllShouldDisplayZeroWhenAllInvoicesAreDeselected() {
        viewModel.downloadInvoiceList()
        viewModel.toggleSelectAll()
        viewModel.toggleSelectAll()
        
        for invoice in viewModel.invoiceList {
            XCTAssertFalse(invoice.isChecked)
        }
        
        XCTAssertEqual(viewModel.totalAmountToPay, 0)
    }
}
