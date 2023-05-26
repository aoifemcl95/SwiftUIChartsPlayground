//
//  StackedChartView.swift
//  SwiftUICharts
//
//  Created by Aoife McLaughlin on 26/05/2023.
//

import SwiftUI
import Charts

enum Status: String, Plottable {
    case criticallyEndangered, endangered, vulnerable, noConcern
}

struct Animal {
    let name: String
    let status: Status
    let proportion: Double
}

struct StackedChartView: View {
    var stackedBarData: [Animal] = [
        Animal(name: "Mammals", status: .criticallyEndangered, proportion: 0.2),
        Animal(name: "Mammals", status: .vulnerable, proportion: 0.35),
        Animal(name:"Mammals", status: .noConcern, proportion: 0.45),
        Animal(name: "Birds", status: .endangered, proportion: 0.2),
        Animal(name: "Birds", status: .vulnerable, proportion: 0.3),
        Animal(name:"Birds", status: .noConcern, proportion: 0.5),
        Animal(name: "Insects", status: .endangered, proportion: 0.15),
        Animal(name: "Insects", status: .vulnerable, proportion: 0.75),
        Animal(name:"Insects", status: .noConcern, proportion: 0.1)
    ]
    var body: some View {
        Chart {
            ForEach(stackedBarData, id: \.name) { animal in
                BarMark(
                    x: .value("Percentage", animal.proportion),
                    y: .value("Name", animal.name)
                )
                .foregroundStyle(by: .value("Status", animal.status))
            }
        }
        .chartXScale(domain: [0, 1.0])
        .frame(height: 250)
        .padding()
    }
}

struct StackedChartView_Previews: PreviewProvider {
    static var previews: some View {
        StackedChartView()
    }
}
