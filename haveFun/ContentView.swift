//
//  ContentView.swift
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

struct ContentView: View {
    @State private var totalAmountToPay: Double = 0.0
    @State private var selectAll: Bool = false

    @State var invoiceList = [
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
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selectAll.toggle()
                    if selectAll {
                        for index in invoiceList.indices {
                            invoiceList[index].isChecked = true
                        }
                        totalAmountToPay = invoiceList.map { $0.dueAmount }.reduce(0, +)
                    } else {
                        for index in invoiceList.indices {
                            invoiceList[index].isChecked = false
                        }
                        totalAmountToPay = 0.0
                    }
                }) {
                    Image(systemName: selectAll ? "checkmark.square" : "square")
                        .frame(width: 20, alignment: .leading)
                    Text("Select All")
                        .font(Font.custom("SF Pro Text", size: 13))
                        .foregroundColor(Color(red: 0.09, green: 0.12, blue: 0.16))
                }
                .padding(.leading, 16)
                Spacer()
            }
            List(invoiceList.indices, id: \.self) { index in
                InvoiceCell(invoice: $invoiceList[index], totalAmountToPay: $totalAmountToPay)
            }
            Spacer() // Pushes the button to the bottom
            
            Button(action: {
                // Your button action here
            }) {
                Text("Pay \(totalAmountToPay, specifier: "%.2f") Lei")
                    .foregroundColor(.white) // White text
                    .padding() // Padding around the text
                    .frame(maxWidth: .infinity) // Makes the button full width
                    .background(Color.green) // Green background
                    .cornerRadius(10) // Rounded corners
            }
            .padding()
        }
    }
}

struct InvoiceCell: View {
    @Binding var invoice: Invoice
    
    @Binding var totalAmountToPay: Double
    
    var body: some View {
        HStack {
            Button(action: {
                invoice.isChecked.toggle()
                if invoice.isChecked {
                    totalAmountToPay += invoice.dueAmount
                } else {
                    totalAmountToPay -= invoice.dueAmount
                }
            }) {
                Image(systemName: invoice.isChecked ? "checkmark.square" : "square")
                    .frame(width: 20, alignment: .leading)
            }
            .padding(.leading, -20)
            AsyncImage(url: URL(string:invoice.providerUrl)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 50, maxHeight: 50)
            } placeholder: {
                ProgressView()
            }
            .padding(.leading, 8)
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                LocationData(
                    locationIcon: invoice.locationIcon,
                    locationName: invoice.locationName
                )
                DueDate(dueDate:invoice.dueDate)
            }
            .padding(.leading, 8)
            Spacer()
            Text(String(invoice.dueAmount) + " Lei")
                .bold()
        }
        .padding()
    }
}

struct LocationData: View {
    let locationIcon: String
    let locationName: String
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string:locationIcon)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 20, maxHeight: 20)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 20, height: 20)
            Text(locationName)
                .font(
                    Font.custom("SF Pro Text", size: 15)
                    .weight(.bold)
                )
        }
    }
}

struct DueDate: View {
    let dueDate: Date
    
    var body: some View {
        HStack {
            AsyncImage(url:URL(string:"https://cdn-icons-png.flaticon.com/512/4513/4513392.png")) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 20, maxHeight: 20)
            } placeholder: {
                ProgressView()
            }
            .frame(width: 20, height: 20)
            Text(getPrettyDueDate(dueDate:dueDate))
                .font(Font.custom("SF Pro Text", size: 15))
                .foregroundColor(Color(red: 0.6, green: 0.65, blue: 0.75))
        }
    }
    
    func getPrettyDueDate(dueDate: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        let formattedDate = formatter.string(from: dueDate)
        return formattedDate
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
