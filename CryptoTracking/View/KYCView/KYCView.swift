//
//  KYCView.swift
//  CryptoTracking
//
//  Created by DuyThai on 04/12/2023.
//

import SwiftUI
import UIKit

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct KYCView: View {
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var title: String = "Personal Inform"
    @State var progressStep: Int = 0
    @State var progressDone: [Bool] = [true, false, false]
    @State var butttonCapTurePress: Bool = false
    @State var capturedCamera = false
    @State var noticeText = "sssssssss"
    @State private var opacityNoticeText: Double = 1.0
    @State private var frontCardImage: UIImage?
    @State private var backCardImage: UIImage?
    @State var isFrontOfCard: Bool =  true


    let stepTitle = ["Personal Inform", "ID Confirm", "Confirm"]

    var body: some View {
        ZStack {
            Color.theme.mainColor.ignoresSafeArea()

            Group {
                ZStack {
                    CameraView(codeTypes: [.qr], scanMode: .manual, captured: $capturedCamera) {  response in
                        switch response {
                        case .success(let result):
                            print("@@@ height navbar: \(coordinator.navigationController.navigationBar.frame.height)")
                            let widthCrect = UIScreen.main.bounds.width - 48
                            let offsetX: CGFloat =  24
                            let offsetY = widthCrect / 2  - coordinator.navigationController.navigationBar.frame.height - 16

                            let crect = CGRect(origin: .zero, size: CGSize(width: widthCrect, height: widthCrect / 1.8)).offsetBy(dx: offsetX, dy: offsetY)

                            let imageScaleAndCut = result.image?.scaleImage()?.capturePortionOfImage(portionRect: crect)
                                if isFrontOfCard {
                                    self.frontCardImage = imageScaleAndCut
                                    isFrontOfCard = false
                                    if backCardImage == nil {
                                        noticeText = "Scan back side card ID"
                                    }
                                } else {
                                    self.backCardImage = imageScaleAndCut

                                    isFrontOfCard = true
                                    if frontCardImage != nil && backCardImage != nil {
                                        noticeText = ""
                                    } else {
                                        noticeText = "Scan front side card ID"
                                    }
                                }
                        case .failure(let error):
                            print("@@@Error: \(error)")
                        }
                        capturedCamera = false

                    }
                    ZStack {
                        Color.black
                            .opacity(0)
                        VisualEffectView(effect: UIBlurEffect(style: .dark))
                    }
                    .mask(ClipSquareCenter().fill(style: .init(eoFill: true)))
                    .ignoresSafeArea()

                    VStack {
                        if  noticeText != "" {
                            Text(noticeText)
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(RoundedRectangle(cornerRadius: 6).foregroundColor(.purpleView))
                                .opacity(opacityNoticeText)
                                .transition(.opacity.animation(.easeInOut(duration: 1)))
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                                        withAnimation(.easeIn(duration: 2)) {
                                            opacityNoticeText = 0.0
                                        }

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.2) {
                                            noticeText = ""
                                            opacityNoticeText = 1.0 // Reset opacity for the next appearance
                                        }

                                    }
                                }
                                .padding(.top, (UIScreen.main.bounds.width - 48) / 2 + 32 )
                        }
                        Spacer()
                    }
                }
            }
            VStack {
                stepView

                VStack{
                    Text("Move your card ID inside the border")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.purple)
                        .padding(.top, (UIScreen.main.bounds.width - 48) * 1.6 / 2 + 4 )

                    Button(action: {
                        capturedCamera.toggle()
                    }, label: {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.all, 12)
                            .background(Circle().foregroundColor(.purple))
                    })
                    .disabled(frontCardImage != nil && backCardImage != nil)
                    .padding(.top, 16)

                    VStack {
                        HStack(spacing: 16) {
                            if frontCardImage == nil {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                    .foregroundColor(.purple)
                                    .overlay(
                                        Image(systemName: "plus")
                                            .font(.system(size: 22, weight: .bold))
                                            .foregroundColor(.white)
                                    )
                            } else {
                                Image(uiImage: frontCardImage ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: (UIScreen.main.bounds.width - 32) / 2 - 8)
                                    .cornerRadius(8, corners: .allCorners)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.purple)
                                                .shadow(color: .black,radius: 2)
                                                .frame(maxWidth: .infinity, alignment: .topTrailing)
                                                .onTapGesture {
                                                    withAnimation(){
                                                        self.frontCardImage = nil
                                                    }
                                                }
                                            Spacer()
                                        }
                                    )
                            }
                            if backCardImage == nil {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [10]))
                                    .foregroundColor(.purple)
                                    .overlay(
                                        ZStack {
                                            Image(systemName: "plus")
                                                .font(.system(size: 22, weight: .bold))
                                                .foregroundColor(.white)
                                        }
                                    )
                            } else {
                                Image(uiImage: backCardImage ?? UIImage())
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: (UIScreen.main.bounds.width - 32) / 2 - 8)
                                    .cornerRadius(8, corners: .allCorners)
                                    .overlay(
                                        VStack {
                                            Image(systemName: "xmark.circle.fill")
                                                .font(.system(size: 20, weight: .bold))
                                                .foregroundColor(.purple)
                                                .shadow(color: .black,radius: 2)
                                                .frame(maxWidth: .infinity, alignment: .topTrailing)
                                                .onTapGesture {
                                                    withAnimation(){
                                                        self.backCardImage = nil
                                                    }
                                                }
                                            Spacer()
                                        }

                                    )
                            }
                        }
                        .frame(maxHeight: 110)
                    }
                    .padding([.horizontal, .top], 16)
                }


                Spacer()

                Button(action: {}, label: {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 16)
                        Spacer()
                   }
                })
                .background(Color.purple.opacity(0.7).cornerRadius(12) )
                .padding(.horizontal, 20)
            }
            .onAppear {
                if frontCardImage == nil && backCardImage == nil {
                    noticeText = "Scan front side card ID"
                } else if frontCardImage == nil  {
                    noticeText = "Scan front side card ID"
                } else if backCardImage == nil {
                    noticeText = "Scan back side card ID"

                }
            }
        }
        .navigationBarHidden(false)

    }
}

extension KYCView {
    var stepView: some View {

        HStack(spacing: 8) {
            VStack {
                Text("Personal")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(self.progressStep == 0 ? .purple : .gray)

                Capsule()
                    .foregroundColor(self.progressDone[0] ? .purple : .gray)
                    .frame(height: 6)
            }
            .onTapGesture {
                withAnimation(.linear) {
                    self.progressStep = 0
                    self.progressDone = [true, false, false]
                }
            }

            VStack {
                Text("ID Confirm")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(self.progressStep == 1 ? .purple : .gray)

                Capsule()
                    .foregroundColor(self.progressDone[1] ? .purple : .gray)
                    .frame(height: 6)
            }
            .onTapGesture {
                withAnimation(.linear) {
                    self.progressStep = 1
                    self.progressDone = [true, true, false]
                }
            }

            VStack {
                Text("Confirm")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(self.progressStep == 2 ? .purple : .gray)

                Capsule()
                    .foregroundColor(self.progressDone[2] ? .purple : .gray)
                    .frame(height: 6)
            }
            .onTapGesture {
                withAnimation(.linear) {
                    self.progressStep = 2
                    self.progressDone = [true, true, true]
                }
            }
        }
        .padding(.horizontal, 16)

    }
}

struct KYCView_Previews: PreviewProvider {
    static var previews: some View {
        KYCView()
    }
}

struct ClipSquareCenter: Shape {
    func path(in rect: CGRect) -> Path {
        let widthCrect = UIScreen.main.bounds.width - 48
        let offsetX:CGFloat =  24
        let offsetY = widthCrect / 2

        let crect = CGRect(origin: .zero, size: CGSize(width: widthCrect, height: widthCrect / 1.8)).offsetBy(dx: offsetX, dy: offsetY)

        var path = Rectangle().path(in: rect)
        path.addPath(RoundedRectangle(cornerRadius: 12).path(in: crect))
        return path
    }
}


extension UIImage {
    func scaleImage(to size: CGSize = UIScreen.main.bounds.size) -> UIImage? {
        let originalImage = self

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        originalImage.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return scaledImage
    }

    func capturePortionOfImage( portionRect: CGRect) -> UIImage? {
        guard let originalImage = self.cgImage else { return nil }

        // Calculate the portion rect in image coordinates
        let imagePortionRect = CGRect(
            x: portionRect.origin.x * self.scale,
            y: portionRect.origin.y * self.scale,
            width: portionRect.width * self.scale,
            height: portionRect.height * self.scale
        )

        // Crop the image to the specified portion
        if let croppedImage = originalImage.cropping(to: imagePortionRect) {
            return UIImage(cgImage: croppedImage, scale: self.scale, orientation: self.imageOrientation)
        }

        return nil
    }
}
