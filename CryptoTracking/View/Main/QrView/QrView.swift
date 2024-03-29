//
//  QrView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI
import AVFoundation
import AVKit
import Combine

struct QrView: View {
    let test = ["sdadasdasdas", "sdaaaa", "asdadada", "asdaasaa"]

    @State var selection = "sdadasdasdas"
    @State var isShowAlert: Bool = false
    @State var errorMessage: String = ""
    @State var session: AVCaptureSession = .init()
    @State var qrOutput: AVCaptureMetadataOutput = .init()
    @State var openFlash: Bool = false
    @State private var isNavigationActive = false

    private var cancellables = Set<AnyCancellable>()
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @Environment(\.openURL) private var openURL

    @State private var selectedImage: UIImage?

    init() {

    }
    var body: some View {
        GeometryReader { geometryEntire in
                ZStack {
//                    CameraViewRepresentable(session: $session, frameSize: CGSize(width: geometryEntire.size.width, height: geometryEntire.size.height)).edgesIgnoringSafeArea(.bottom)
                    CodeScannerView(codeTypes: [.qr], scanMode: .manual ,manualSelect: true, showViewfinder: true, isTorchOn: true){ response in
                        switch response {
                        case .success(let result):
                            print("@@@QrRs: \(result)")
                            coordinator.show(.afterScan(url: "https://www.gate.io/buy_crypto?type=buy&method=bank&fiat=USD&crypto=USDT"))
                        case .failure(let error):
                            print("@@@Error: \(error)")
                        }
                    }
//                    Color.red

//                VStack (alignment: .center){
//                        Button(action: {}, label: {
//                            HStack {
//                                Image(systemName: "qrcode")
//                                    .resizable()
//                                    .frame(width: 16, height: 16)
//                                    .font(.system(size: 20, weight: .bold))
//                                    .foregroundColor(.purple)
//                                Text("My QR code")
//                                    .font(.system(size: 16, weight: .medium))
//                                    .foregroundColor(.white)
//                            }
//                            .padding(.all, 8)
//                        })
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(12)
//                    Spacer(minLength: 16)
//
//                    Text("Move camera in to QR to scan")
//                        .font(.system(size: 15, weight: .bold))
//                        .foregroundColor(.white)
//                    Spacer(minLength: 0)
//
//                    GeometryReader { geometryReader in
//                            ZStack {
//
//                                ForEach(0...4, id: \.self) { index in
//                                    let rotation = Double(index) * 90
//                                    RoundedRectangle(cornerRadius: 8, style: .circular)
//                                        .trim(from: 0.61, to: 0.64)
//                                        .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
//                                        .rotationEffect(Angle(degrees: rotation))
//                                }
//                            }
//                            .frame(width:  geometryReader.size.width, height: geometryReader.size.width)
//                        .frame(maxWidth: .infinity)
//                    }
//                    .padding(.horizontal, 45)
//
//                    HStack(alignment: .center) {
//                        Spacer()
//                        Button(action: { openFlash.toggle()
//
//                            coordinator.show(.afterScan(url: "https://www.gate.io/buy_crypto?type=buy&fiat=USD&crypto=USDT"), isNavigationBarHidden: false)
//                        }, label: {
//                            VStack {
//                                VStack(spacing: 0) {
//                                    Image(systemName: openFlash ? "light.max" : "light.min")
//                                        .font(.system(size: 16, weight: .bold))
//                                        .foregroundColor(.white)
//                                        .padding(.bottom, -1)
//                                    Image(systemName: openFlash ? "flashlight.on.fill" : "flashlight.on.fill")
//                                        .resizable()
//                                        .frame(width: 14, height: 22)
//                                        .foregroundColor(.white)
//                                }
//                                .padding(.all, 20)
//                                .background(
//                                    Circle()
//                                        .stroke(style: .init(lineWidth: 3))
//                                        .foregroundColor(.white)
//                                        .background( Circle().foregroundColor(.white.opacity(0)))
//                                )
//                                Text("Light")
//                                    .font(.system(size: 16, weight: .bold))
//                                    .foregroundColor(.white)
//                            }
//                        })
//                        Spacer(minLength: 8)
//                        Button(action: {  openPhotoLibrary() }, label: {
//                            VStack {
//                                VStack(spacing: 0) {
//                                    Image(systemName: "photo.fill")
//                                        .font(.system(size: 22, weight: .bold))
//                                        .foregroundColor(.white)
//                                        .padding(.bottom, -1)
//                                }
//                                .padding(.all, 18)
//                                .background(
//                                    Circle()
//                                        .stroke(style: .init(lineWidth: 3))
//                                        .foregroundColor(.white)
//                                        .background( Circle().foregroundColor(.white.opacity(0)))
//                                )
//                                Text("Upload QR")
//                                    .font(.system(size: 16, weight: .bold))
//                                    .foregroundColor(.white)
//                            }
//                        })
//                        Spacer()
//                    }
//
//                }
//                .padding(.vertical, 120)
//                    if viewModel.qrcodeValue != "" {
//
//                        Text("Show")
//                            .onAppear {
//                                coordinator.show(.afterScan(url: "https://www.gate.io/buy_crypto?type=buy&fiat=USD&crypto=USDT"), isNavigationBarHidden: false)
//                            }
//                    }
            }
            .onAppear {
//                DispatchQueue.global(qos: .background).async {
//                    session.startRunning()
//
//                }
            }
            .onDisappear {
//                session.stopRunning()
            }
        }
    }

}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }

}
