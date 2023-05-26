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

struct ChartViewModel {
    var data: [Income] =
        [
            Income(name: "UK Average", amount: 1_436_866),
            Income(name: "Duchy of Cornwall", amount: 612_608_642),
            Income(name: "Duchy of Lancaster", amount: 603_623_223)
        ]
}

struct IncomeChart: View {
    let viewModel = ChartViewModel()
    var body: some View {
        Chart {
            ForEach(viewModel.data, id: \.name) { incomeData in
                BarMark(x: .value("Name", incomeData.name), y: .value("Cumulative amount", incomeData.amount))
                    .foregroundStyle(by: .value("Name", incomeData.name))
            }
        }
        // FIXME: format y axis labels 
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeChart()
    }
}
