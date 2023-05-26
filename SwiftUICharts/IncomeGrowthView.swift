//
//  IncomeGrowth.swift
//  SwiftUICharts
//
//  Created by Aoife McLaughlin on 25/05/2023.
//

import SwiftUI
import Charts

enum Source: String, CaseIterable {
    case ukAverage, duchy
}

struct IncomeGrowth: Identifiable {
    let year: Int
    let growthFactor: Double
    
    let id = UUID()
}

struct IncomeData {
    let source: String // purposely a String in order to get foregroundStyle(by:) to work correctly
    let income: [IncomeGrowth]
}

struct IncomeGrowthViewModel {
    static var ukAverageData: [IncomeGrowth] = [
        IncomeGrowth(year: 1_955, growthFactor: 1),
        IncomeGrowth(year: 1_960, growthFactor: 1.1),
        IncomeGrowth(year: 1_965, growthFactor: 1.3),
        IncomeGrowth(year: 1_970, growthFactor: 1.5),
        IncomeGrowth(year: 1_975, growthFactor: 1.7),
        IncomeGrowth(year: 1_980, growthFactor: 1.8),
        IncomeGrowth(year: 1_985, growthFactor: 2.1),
        IncomeGrowth(year: 1_990, growthFactor: 2.35),
        IncomeGrowth(year: 1_995, growthFactor: 2.5),
        IncomeGrowth(year: 2_000, growthFactor: 2.65),
        IncomeGrowth(year: 2_005, growthFactor: 3.2),
        IncomeGrowth(year: 2_010, growthFactor: 3.8),
        IncomeGrowth(year: 2_015, growthFactor: 4.5),
        IncomeGrowth(year: 2_020, growthFactor: 4.2)
    ]
    
    static var duchyData: [IncomeGrowth] = [
        IncomeGrowth(year: 1_955, growthFactor: 1),
        IncomeGrowth(year: 1_960, growthFactor: 1.1),
        IncomeGrowth(year: 1_965, growthFactor: 1.3),
        IncomeGrowth(year: 1_970, growthFactor: 1.5),
        IncomeGrowth(year: 1_975, growthFactor: 1.7),
        IncomeGrowth(year: 1_980, growthFactor: 1.8),
        IncomeGrowth(year: 1_985, growthFactor: 3.0),
        IncomeGrowth(year: 1_990, growthFactor: 4.1),
        IncomeGrowth(year: 1_995, growthFactor: 6.0),
        IncomeGrowth(year: 2_000, growthFactor: 7.5),
        IncomeGrowth(year: 2_005, growthFactor: 8.2),
        IncomeGrowth(year: 2_010, growthFactor: 15),
        IncomeGrowth(year: 2_015, growthFactor: 20),
        IncomeGrowth(year: 2_020, growthFactor: 18)
    ]
    
    static var data: [IncomeData] = [
        IncomeData(source: "Duchy", income: duchyData),
        IncomeData(source: "UK Average", income: ukAverageData)
    ]
    
}

struct IncomeGrowthView: View {
    var body: some View {
        Chart {
            ForEach(IncomeGrowthViewModel.data, id: \.source) { incomeData in
                ForEach(incomeData.income) { incomeGrowth in
                    LineMark(x: .value("Year",
                                       incomeGrowth.year),
                             y: .value("Growth increase", incomeGrowth.growthFactor))
                }
                .foregroundStyle(by: .value("Source", incomeData.source))
            }
            
        }
        .padding()
        .chartXScale(domain: [1950, 2020])
        .chartXAxis {
            AxisMarks(values: .automatic(desiredCount: IncomeGrowthViewModel.ukAverageData.count))
        }
    }
}

struct IncomeGrowth_Previews: PreviewProvider {
    static var previews: some View {
        IncomeGrowthView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
