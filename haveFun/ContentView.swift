//
//  ContentView.swift
//  haveFun
//
//  Created by Adrian Coman on 01.10.2023.
//

import SwiftUI



struct ContentView: View {
    @StateObject var viewModel = InvoiceViewModel(repository:RemoteDataSource())
    
    var body: some View {
        VStack {
            HStack {
                Button(action: viewModel.toggleSelectAll) {
                    Image(systemName: viewModel.selectAll ? "checkmark.square" : "square")
                        .frame(width: 20, alignment: .leading)
                    Text("Select All")
                        .font(Font.custom("SF Pro Text", size: 13))
                        .foregroundColor(Color(red: 0.09, green: 0.12, blue: 0.16))
                }
                .padding(.leading, 16)
                Spacer()
            }
            List(viewModel.invoiceList.indices, id: \.self) { index in
                InvoiceCell(
                    invoice: $viewModel.invoiceList[index],
                    totalAmountToPay: $viewModel.totalAmountToPay
                )
            }
            Spacer() // Pushes the button to the bottom
            
            Button(action: {
                // Your button action here
            }) {
                Text("Pay \(viewModel.totalAmountToPay, specifier: "%.2f") Lei")
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
