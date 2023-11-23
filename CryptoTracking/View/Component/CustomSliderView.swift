//
//  CustomSliderView.swift
//  CryptoTracking
//
//  Created by DuyThai on 16/11/2023.
//

import SwiftUI

struct CustomSliderView<Content>: View where Content: View {
    @State var slider: Float = 0
    @State var dragGestureTranslation: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    @State var steppedSlider: Bool = false
    @State var step: Int = 5
    @State var stepInterval: CGFloat = 200
    @State var maxWidthProgressBar: CGFloat = 0
    @State var height: CGFloat = 20
    @State var progressColor: Color = .blue

    var customSliderHeight: CGFloat = 16
    var customSliderWidth: CGFloat = 16

    let customSlider: Content

    var sliderWidth: CGFloat = 20
    var sliderPadding: CGFloat = 0

    @Binding var percentProgress: Double
    func interval(width: CGFloat, increment: Int) -> CGFloat {
        let result = width * CGFloat(increment) / CGFloat(step)
        return result
    }

    func roundToFactor(value: CGFloat, factor: CGFloat) -> CGFloat {
        return factor * round(value / factor)
    }
    @State private var tappedLocation: CGPoint? = nil
    var body: some View {
        VStack {
            GeometryReader { geometry in
                // Slider Bar
                ZStack (alignment: .leading) {
                    Rectangle()
                        .foregroundColor(progressColor)
                        .onTouchPosition { position in
                            self.slider =  Float(position.x > maxWidthProgressBar ? maxWidthProgressBar :  position.x)
                        }
                } // End of Slider Bar
                .frame(width: geometry.size.width, height: 3)
                .padding(.vertical, 15)
                .onAppear {
                    maxWidthProgressBar = geometry.size.width - sliderWidth - sliderPadding * 2
                }// Padding to centre the bar

                // Slider Stacker
                ZStack{
                    customSlider
                        .frame(width: customSliderWidth, height: customSliderHeight)
                }
                .offset(x: CGFloat(slider), y: sliderWidth / 2)
                .padding(.horizontal, sliderPadding)
                .gesture(DragGesture(minimumDistance: 0)
                    .onChanged({ dragValue in
                        let translation = dragValue.translation

                        dragGestureTranslation = CGFloat(translation.width) + lastDragValue

                        // Set the start marker of the slider
                        dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0

                        // Set the end marker of the slider
                        dragGestureTranslation = dragGestureTranslation > (geometry.size.width - sliderWidth - sliderPadding * 2) ? (geometry.size.width - sliderWidth - sliderPadding * 2) :  dragGestureTranslation

                        // Set the slider value (Stepped)
                        if steppedSlider {
                            // Getting the stepper interval (where to place the marks)
                            stepInterval = roundToFactor(value: dragGestureTranslation, factor: (geometry.size.width - sliderWidth - (sliderPadding * 2)) / CGFloat(step))

                            // Get the increments for the stepepdInterval
                            self.slider = min(max(0, Float(stepInterval)), Float(stepInterval))
                        } else {
                            // Set the slider value (Fluid)
                            self.slider = min(max(0, Float(dragGestureTranslation)), Float(dragGestureTranslation))
                        }
                        percentProgress = Double(slider) / maxWidthProgressBar

                    })
                        .onEnded({ dragValue in
                            // Set the start marker of the slider
                            dragGestureTranslation = dragGestureTranslation >= 0 ? dragGestureTranslation : 0

                            // Set the end marker of the slider
                            dragGestureTranslation = dragGestureTranslation > (geometry.size.width - sliderWidth - sliderPadding * 2) ? (geometry.size.width - sliderWidth - sliderPadding * 2) : dragGestureTranslation

                            lastDragValue = dragGestureTranslation
                            percentProgress = Double(slider) / maxWidthProgressBar

                        })
                )
            }
        }
        .frame(height: customSliderHeight)
    }

}
