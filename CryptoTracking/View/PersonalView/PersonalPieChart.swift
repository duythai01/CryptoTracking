//
//  PersonalPieChart.swift
//  CryptoTracking
//
//  Created by DuyThai on 06/11/2023.
//

import Foundation
import SwiftUI
import Charts


struct PersonalPieChart: UIViewRepresentable {
    let entries = DeveloperPreview.shared.parties.map {
              // IMPORTANT: In a PieChart, no values (Entry) should have the same xIndex (even if from different DataSets), since no values can be drawn above each other.
        PieChartDataEntry(value: $0.currencyHold, label: $0.id, icon: UIImage(systemName: "square.and.arrow.down.fill"))
          }

    let totalAsset: String

    func makeUIView(context: Context) -> PieChartView {
        return PieChartView()
    }


    func updateUIView(_ uiView: PieChartView, context: Context) {
        uiView.usePercentValuesEnabled = true
        uiView.drawSlicesUnderHoleEnabled = true
        uiView.holeRadiusPercent = 0.4
        uiView.transparentCircleRadiusPercent = 0.42
        uiView.holeColor = UIColor(Color.theme.mainColor)
        uiView.chartDescription.enabled = false
//        uiView.setExtraOffsets(left: 5, top: 10, right: 5, bottom: 5)
        uiView.drawCenterTextEnabled = true

        // Set text
        let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .byTruncatingTail
        paragraphStyle.alignment = .center

        let centerText = NSMutableAttributedString(string: "Total asset\n\(totalAsset)")
        centerText.setAttributes([.font : UIFont(name: "HelveticaNeue-Bold", size: 13)!, .foregroundColor : UIColor.white,
                                  .paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: centerText.length))
//        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//                                  .foregroundColor : UIColor.gray], range: NSRange(location: 10, length: centerText.length - 10))
//        centerText.addAttributes([.font : UIFont(name: "HelveticaNeue-Light", size: 11)!,
//                                  .foregroundColor : UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)], range: NSRange(location: centerText.length - 19, length: 19))
        uiView.centerAttributedText = centerText;

        uiView.drawHoleEnabled = true
        uiView.rotationAngle = 0
        uiView.rotationEnabled = false
        uiView.highlightPerTapEnabled = false

        uiView.legend.horizontalAlignment = .right
        uiView.legend.verticalAlignment = .top
        uiView.legend.orientation = .vertical
        uiView.legend.xEntrySpace = 7
        uiView.legend.yEntrySpace = 0
        uiView.legend.yOffset = 0
        uiView.legend.textColor = .white
        uiView.legend.enabled = false
        setDataPieChart(pieChartView: uiView)
    }

    func setDataPieChart(pieChartView: PieChartView) {
        let set = PieChartDataSet(entries: entries, label: "")
        set.drawIconsEnabled = false
        set.sliceSpace = 0
        set.colors = ChartColorTemplates.vordiplom()
        + ChartColorTemplates.joyful()
        + ChartColorTemplates.colorful()
        + ChartColorTemplates.liberty()
        + ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent

        pFormatter.maximumFractionDigits = 2

        pFormatter.percentSymbol = " %"

        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueFont(.systemFont(ofSize: 11, weight: .semibold ))
        data.setValueTextColor(.black)
        pieChartView.data = data
        pieChartView.highlightValues(nil)
    }

}


struct PersonalPieChart_Previews: PreviewProvider {

    static var previews: some View {
        PersonalPieChart(totalAsset: "10000 USD")
    }
}
