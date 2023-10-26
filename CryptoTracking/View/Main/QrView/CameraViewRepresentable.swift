//
//  CameraViewRepresentable.swift
//  CryptoTracking
//
//  Created by DuyThai on 24/10/2023.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation

struct CameraViewRepresentable: UIViewRepresentable {

    @Binding var session: AVCaptureSession
    var frameSize: CGSize
    func makeUIView(context: Context) -> UIView {
        let view = UIViewType(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: frameSize))
        view.backgroundColor = .clear
        let cameraLayer = AVCaptureVideoPreviewLayer(session: session)
        cameraLayer.frame = .init(origin: .zero, size: frameSize)
        cameraLayer.videoGravity = .resizeAspectFill
        cameraLayer.masksToBounds = true
        view.layer.addSublayer(cameraLayer)
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    
    }
}
