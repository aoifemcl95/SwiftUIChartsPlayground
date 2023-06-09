//
//  ContentView.swift
//  SwiftUICharts
//
//  Created by Aoife McLaughlin on 25/05/2023.
//

import SwiftUI
import Charts

struct Income {
    let name: String
    let amount: Int
}

class ChartViewModel: ObservableObject {
    @Published var data: [Income] = [
        Income(name: "UK Average", amount: 0),
        Income(name: "Duchy of Cornwall", amount: 0),
        Income(name: "Duchy of Lancaster", amount: 0)
    ]
    var totalData: [Income] =
        [
            Income(name: "UK Average", amount: 1_436_866),
            Income(name: "Duchy of Cornwall", amount: 612_608_642),
            Income(name: "Duchy of Lancaster", amount: 603_623_223)
        ]
    
    func updateData() {
        self.data = totalData
    }
}

struct IncomeChart: View {
    @ObservedObject var viewModel = ChartViewModel()
    var body: some View {
        Chart {
            ForEach(viewModel.data, id: \.name) { incomeData in
                BarMark(x: .value("Name", incomeData.name), y: .value("Cumulative amount", incomeData.amount))
                    .foregroundStyle(by: .value("Name", incomeData.name))
                    .annotation(alignment: .top) {
                        Text(formattedString(for:incomeData.amount))
                    }
            }
        }
        .chartYScale(domain: [0, 650_608_642]) // needed to ensure animation only affects bars
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .padding()
        .onAppear {
            withAnimation(.easeInOut(duration: 1.2)) {
                viewModel.updateData()
            }
        }
    }
    
    func formattedString(for value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
                formatter.minimumIntegerDigits = 7
        formatter.maximumFractionDigits = 0
        let number = NSNumber(value: value)
        return formatter.string(from: number) ?? ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeChart()
    }
}
