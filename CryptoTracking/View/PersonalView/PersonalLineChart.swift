//
//  PersonalChart.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/11/2023.
//

import Foundation
import SwiftUI
import Charts

struct Transaction {
    var year: Int
    var month: Int
    var quantity: Double

    static var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    static func dataEntriesForYear(_ year: Int, transactions:[Transaction]) -> [BarChartDataEntry] {
        let yearTransactions = transactions.filter{$0.year == year}
        return yearTransactions.map {
            BarChartDataEntry(x: Double($0.month), y: $0.quantity)
        }


    }

    static var allTransactions: [Transaction] = [
        Transaction(year: 2022, month: 1, quantity: 16),
        Transaction(year: 2023, month: 2, quantity: 42),
        Transaction(year: 2021, month: 10, quantity: 35),
        Transaction(year: 2023, month: 12, quantity: 68),
        Transaction(year: 2023, month: 11, quantity: 12),
        Transaction(year: 2023, month: 3, quantity: 67),
        Transaction(year: 2023, month: 5, quantity: 123),
        Transaction(year: 2021, month: 4, quantity: 44),
        Transaction(year: 2019, month: 6, quantity: 45),
        Transaction(year: 2019, month: 8, quantity: 22),
        Transaction(year: 2022, month: 5, quantity: 75),
        Transaction(year: 2022, month: 6, quantity: 12),
        Transaction(year: 2022, month: 9, quantity: 78),
        Transaction(year: 2019, month: 2, quantity: 44),
        Transaction(year: 2021, month: 10, quantity: 56),
        Transaction(year: 2021, month: 12, quantity: 96),
        Transaction(year: 2021, month: 11, quantity: 88),
        Transaction(year: 2023, month: 11, quantity: 42),
        Transaction(year: 2022, month: 11, quantity: 76),
        Transaction(year: 2021, month: 4, quantity: 12),
        Transaction(year: 2023, month: 6, quantity: 34),
        Transaction(year: 2023, month: 6, quantity: 67),
        Transaction(year: 2021, month: 7, quantity: 34),
        Transaction(year: 2022, month: 7, quantity: 22),
        Transaction(year: 2019, month: 6, quantity: 32),
        Transaction(year: 2019, month: 6, quantity: 24),
        Transaction(year: 2022, month: 6, quantity: 87),
        Transaction(year: 2022, month: 6, quantity: 65),
        Transaction(year: 2023, month: 7, quantity: 23),
        Transaction(year: 2022, month: 1, quantity: 86),
        Transaction(year: 2021, month: 4, quantity: 96),
        Transaction(year: 2019, month: 2, quantity: 23),
        Transaction(year: 2023, month: 2, quantity: 77),
        Transaction(year: 2019, month: 4, quantity: 45),
        Transaction(year: 2019, month: 9, quantity: 76),

]


    static func mapChartDataEntry(price7D: [Double]) -> [ChartDataEntry] {
        let chartDataEntry: [ChartDataEntry] = price7D.enumerated().map { index, price in
            return ChartDataEntry(x: Double(index + 1), y: price)
        }
        return chartDataEntry
    }
}

struct PersonalLineChart: UIViewRepresentable {
    let entries: [ChartDataEntry]
    let chartColor: UIColor

    func makeUIView(context: Context) -> LineChartView {
        return LineChartView()
    }

    func updateUIView(_ uiView: LineChartView, context: Context) {
        let dataSet = LineChartDataSet(entries: entries)
        formatDataSet(dataSet: dataSet)
        uiView.backgroundColor = .clear
//        uiView.legend.form = .circle
        uiView.leftAxis.enabled = false
        uiView.rightAxis.enabled = false
        uiView.xAxis.enabled = false
        uiView.legend.form = .none
        formatRightAxis(rightAxis: uiView.rightAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        uiView.lineData?.setDrawValues(false)
        uiView.data = LineChartData(dataSet: dataSet)
        uiView.pinchZoomEnabled = false
        uiView.doubleTapToZoomEnabled = false
    }

    func formatDataSet(dataSet: LineChartDataSet) {
        dataSet.drawHorizontalHighlightIndicatorEnabled = false

        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 2
        dataSet.setColor(chartColor)
//        dataSet.fill = ColorFill(color: .blue)
        dataSet.fillAlpha = 0
        dataSet.drawFilledEnabled = true
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.label = .none
        dataSet.mode = .linear
    }

    func formatRightAxis(rightAxis: YAxis) {

    }

    func formatLeftAxis(leftAxis: YAxis) {
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.valueFormatter = IndexAxisValueFormatter(values: Transaction.months)
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 90
    }

}


struct PersonalChart_Previews: PreviewProvider {
    static var previews: some View {
        PersonalLineChart(entries:
                        Transaction.mapChartDataEntry(price7D: DeveloperPreview.shared.coin.sparklineIn7D?.price ?? []),
                      chartColor: .green)
    }
}
