//
//  QrView.swift
//  CryptoTracking
//
//  Created by DuyThai on 03/10/2023.
//

import SwiftUI
import AVFoundation
import AVKit

struct QrView: View {
    let test = ["sdadasdasdas", "sdaaaa", "asdadada", "asdaasaa"]

    @State var selection = "sdadasdasdas"
    @State var cameraPermisson: PermissonType = .idle
    @State var isShowAlert: Bool = false
    @State var errorMessage: String = ""
    @State var session: AVCaptureSession = .init()
    @State var qrOutput: AVCaptureMetadataOutput = .init()
    @State var openFlash: Bool = false

    @Environment(\.openURL) private var openURL

    let viewModel = QRScannerViewModel()
    var body: some View {
        GeometryReader { geometryEntire in
                ZStack {
                    CameraViewRepresentable(session: $session, frameSize: CGSize(width: geometryEntire.size.width, height: geometryEntire.size.height)).edgesIgnoringSafeArea(.vertical)
//                    Color.red

                VStack (alignment: .center){
                        Button(action: {}, label: {
                            HStack {
                                Image(systemName: "qrcode")
                                    .resizable()
                                    .frame(width: 16, height: 16)
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.purple)
                                Text("My QR code")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.white)
                            }
                            .padding(.all, 8)
                        })
                        .background(Color.white.opacity(0.2))
                        .cornerRadius(12)
                    Spacer(minLength: 16)

                    Text("Move camera in to QR to scan")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                    Spacer(minLength: 0)

                    GeometryReader { geometryReader in
                            ZStack {

                                ForEach(0...4, id: \.self) { index in
                                    let rotation = Double(index) * 90
                                    RoundedRectangle(cornerRadius: 8, style: .circular)
                                        .trim(from: 0.61, to: 0.64)
                                        .stroke(Color.white, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                        .rotationEffect(Angle(degrees: rotation))
                                }
                            }
                            .frame(width:  geometryReader.size.width, height: geometryReader.size.width)
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 45)

                    HStack(alignment: .center) {
                        Spacer()
                        Button(action: { openFlash.toggle() }, label: {
                            VStack {
                                VStack(spacing: 0) {
                                    Image(systemName: openFlash ? "light.max" : "light.min")
                                        .font(.system(size: 16, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, -1)
                                    Image(systemName: openFlash ? "flashlight.on.fill" : "flashlight.on.fill")
                                        .resizable()
                                        .frame(width: 14, height: 22)
                                        .foregroundColor(.white)
                                }
                                .padding(.all, 20)
                                .background(
                                    Circle()
                                        .stroke(style: .init(lineWidth: 3))
                                        .foregroundColor(.white)
                                        .background( Circle().foregroundColor(.white.opacity(0)))
                                )
                                Text("Light")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        })
                        Spacer(minLength: 8)
                        Button(action: { openFlash.toggle() }, label: {
                            VStack {
                                VStack(spacing: 0) {
                                    Image(systemName: "photo.fill")
                                        .font(.system(size: 22, weight: .bold))
                                        .foregroundColor(.white)
                                        .padding(.bottom, -1)
                                }
                                .padding(.all, 18)
                                .background(
                                    Circle()
                                        .stroke(style: .init(lineWidth: 3))
                                        .foregroundColor(.white)
                                        .background( Circle().foregroundColor(.white.opacity(0)))
                                )
                                Text("Upload QR")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        })
                        Spacer()
                    }

                }
                .padding(.vertical, 120)
            }
            .onAppear {
                print("@@@: QrView appear")
                checkCameraPermission()
            }
            .onDisappear {
                print("@@@: QrView disappear")
                session.stopRunning()
            }
            .alert(isPresented: $isShowAlert, content: {
                Alert(
                    title: Text(errorMessage),
                    primaryButton: .default(Text("Settings")) {
                        if cameraPermisson == .denied {
                            let settingString = UIApplication.openSettingsURLString
                            if let settingsURL = URL(string: settingString) {
                                openURL(settingsURL)
                        }
                        }
                    },
                    secondaryButton: .cancel()
                )
        })
        }
    }
}

struct QrView_Previews: PreviewProvider {
    static var previews: some View {
        QrView()
    }

}

extension QrView {
    func checkCameraPermission() {
        Task {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                cameraPermisson = .approved
                setupCamera()
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video) {
                    cameraPermisson = .approved
                    setupCamera()
                } else {
                    cameraPermisson = .denied
                    presentError("Please provide access to camera for scanning")
                }
            case .denied, .restricted:
                cameraPermisson = .denied
                presentError("Please provide access to camera for scanning")
            default:
                break

            }
        }
    }

     func presentError(_ message: String) {
        errorMessage = message
        isShowAlert.toggle()
    }
}

extension QrView {
    func setupCamera() {
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: .video, position: .back).devices.first  else {
                presentError("Device not suppore")
                return
            }
            let input = try AVCaptureDeviceInput(device: device)
            guard session.canAddInput(input), session.canAddOutput(qrOutput)else {
                presentError("UNKMOWN")
                return
            }

            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(viewModel, queue: .main)
            session.commitConfiguration()
            DispatchQueue.global(qos: .background).async {
                session.startRunning()

            }
        } catch {
            presentError("load camera fail")
        }
    }
}

enum PermissonType: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access  Denied"
}
