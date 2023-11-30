//
//  CoinCandleStickChart.swift
//  CryptoTracking
//
//  Created by DuyThai on 21/11/2023.
//

import Foundation
import SwiftUI
import Charts

struct CandleStickCoin: Identifiable {
    let id = UUID().uuidString
    let name: String
    let day: Int
    let lowPrice: Double
    let highPrice: Double
    let openPrice: Double
    let closePrice: Double

    static let entryies: [CandleStickCoin] = [
        CandleStickCoin(name: "BTC", day: 1, lowPrice: 3000, highPrice: 7000, openPrice: 3500, closePrice: 6000),
        CandleStickCoin(name: "BTC", day: 2, lowPrice: 6000, highPrice: 7500, openPrice: 6500, closePrice: 6200),
        CandleStickCoin(name: "BTC", day: 3, lowPrice: 2000, highPrice: 4050, openPrice: 3800, closePrice: 3000),
        CandleStickCoin(name: "BTC", day: 5, lowPrice: 5000, highPrice: 9000, openPrice: 5600, closePrice: 8000),
        CandleStickCoin(name: "BTC", day: 6, lowPrice: 4000, highPrice: 4500, openPrice: 4100, closePrice: 4400),
        CandleStickCoin(name: "BTC", day: 7, lowPrice: 3000, highPrice: 5000, openPrice: 3500, closePrice: 4600),
        CandleStickCoin(name: "BTC", day: 17, lowPrice: 2000, highPrice: 4050, openPrice: 3800, closePrice: 3000),
        CandleStickCoin(name: "BTC", day: 25, lowPrice: 7000, highPrice: 8000, openPrice: 7200, closePrice: 7000),
        CandleStickCoin(name: "BTC", day: 26, lowPrice: 5000, highPrice: 9000, openPrice: 5600, closePrice: 8000),
        CandleStickCoin(name: "BTC", day: 27, lowPrice: 4000, highPrice: 4500, openPrice: 4100, closePrice: 4400),
        CandleStickCoin(name: "BTC", day: 28, lowPrice: 3000, highPrice: 5000, openPrice: 3500, closePrice: 4600),
        CandleStickCoin(name: "BTC", day: 29, lowPrice: 3000, highPrice: 7000, openPrice: 3500, closePrice: 6000),
        CandleStickCoin(name: "BTC", day: 18, lowPrice: 7000, highPrice: 8000, openPrice: 7200, closePrice: 7000),
        CandleStickCoin(name: "BTC", day: 20, lowPrice: 4000, highPrice: 4500, openPrice: 4100, closePrice: 4400),
        CandleStickCoin(name: "BTC", day: 21, lowPrice: 3000, highPrice: 5000, openPrice: 3500, closePrice: 4600),
        CandleStickCoin(name: "BTC", day: 22, lowPrice: 3000, highPrice: 7000, openPrice: 3500, closePrice: 6000),
        CandleStickCoin(name: "BTC", day: 23, lowPrice: 6000, highPrice: 7500, openPrice: 6500, closePrice: 6200),
        CandleStickCoin(name: "BTC", day: 24, lowPrice: 2000, highPrice: 4050, openPrice: 3800, closePrice: 3000),
        CandleStickCoin(name: "BTC", day: 8, lowPrice: 3000, highPrice: 7000, openPrice: 3500, closePrice: 6000),
        CandleStickCoin(name: "BTC", day: 9, lowPrice: 6000, highPrice: 7500, openPrice: 6500, closePrice: 6200),
        CandleStickCoin(name: "BTC", day: 10, lowPrice: 2000, highPrice: 4050, openPrice: 3800, closePrice: 3000),
        CandleStickCoin(name: "BTC", day: 11, lowPrice: 7000, highPrice: 8000, openPrice: 7200, closePrice: 7000),
        CandleStickCoin(name: "BTC", day: 12, lowPrice: 5000, highPrice: 9000, openPrice: 5600, closePrice: 8000),
        CandleStickCoin(name: "BTC", day: 13, lowPrice: 4000, highPrice: 4500, openPrice: 4100, closePrice: 4400),
        CandleStickCoin(name: "BTC", day: 15, lowPrice: 3000, highPrice: 7000, openPrice: 3500, closePrice: 6000),
        CandleStickCoin(name: "BTC", day: 16, lowPrice: 6000, highPrice: 7500, openPrice: 6500, closePrice: 6200),
        CandleStickCoin(name: "BTC", day: 30, lowPrice: 6000, highPrice: 7500, openPrice: 6500, closePrice: 6200),
        CandleStickCoin(name: "BTC", day: 31, lowPrice: 2000, highPrice: 4050, openPrice: 3800, closePrice: 3000),
        CandleStickCoin(name: "BTC", day: 32, lowPrice: 7000, highPrice: 8000, openPrice: 7200, closePrice: 7000),
        CandleStickCoin(name: "BTC", day: 33, lowPrice: 5000, highPrice: 9000, openPrice: 5600, closePrice: 8000),
        CandleStickCoin(name: "BTC", day: 34, lowPrice: 4000, highPrice: 4500, openPrice: 4100, closePrice: 4400),
        CandleStickCoin(name: "BTC", day: 35, lowPrice: 3000, highPrice: 5000, openPrice: 3500, closePrice: 4600),]
}

struct CoinCandleStickChart: UIViewRepresentable {
    let entries: [CandleChartDataEntry]
    let chartColor: UIColor

    func makeUIView(context: Context) -> CandleStickChartView {
        return CandleStickChartView()
    }

    func updateUIView(_ uiView: CandleStickChartView, context: Context) {
        let dataSet = CandleChartDataSet(entries: entries)
        formatDataSet(dataSet: dataSet)
//        uiView.backgroundColor = .black
//        uiView.legend.form = .circle
        uiView.leftAxis.enabled = false
        uiView.rightAxis.enabled = false
        uiView.xAxis.enabled = true
        uiView.xAxis.labelTextColor = .white
        uiView.legend.form = .none
        formatRightAxis(rightAxis: uiView.rightAxis)
        formatLeftAxis(leftAxis: uiView.leftAxis)
        formatXAxis(xAxis: uiView.xAxis)
        uiView.data = CandleChartData(dataSet: dataSet)
        uiView.pinchZoomEnabled = true
        uiView.doubleTapToZoomEnabled = false
    }

    func formatDataSet(dataSet: CandleChartDataSet) {
        dataSet.drawHorizontalHighlightIndicatorEnabled = false

        dataSet.drawIconsEnabled = false
//        dataSet.shadowColor = .black
        dataSet.shadowWidth = 1
        dataSet.shadowColorSameAsCandle = true
        dataSet.decreasingColor = .red
        dataSet.decreasingFilled = true
        dataSet.increasingColor = .green
        dataSet.increasingFilled = true
        dataSet.neutralColor = .blue
        dataSet.valueTextColor = .clear
        dataSet.drawVerticalHighlightIndicatorEnabled = false
        dataSet.label = .none

    }

    func formatRightAxis(rightAxis: YAxis) {

    }

    func formatLeftAxis(leftAxis: YAxis) {
    }

    func formatXAxis(xAxis: XAxis) {
        xAxis.valueFormatter = IndexAxisValueFormatter(values: entries.map {
            "\($0.x)"
        })
        xAxis.labelPosition = .bottom
//        xAxis.labelRotationAngle = 90
    }

}


struct CoinCandleStickChart_Previews: PreviewProvider {
    static var previews: some View {
        CoinCandleStickChart(entries: CandleStickCoin.entryies.map {
            CandleChartDataEntry(x: Double($0.day), shadowH: $0.highPrice, shadowL: $0.lowPrice, open: $0.openPrice, close: $0.closePrice)
        }, chartColor: .red)
    }
}
