//
//  CameraView.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/12/2023.
//

import Foundation
import SwiftUI
import UIKit
import AVFoundation

public struct CameraView: UIViewControllerRepresentable {
    public let codeTypes: [AVMetadataObject.ObjectType]
    public var scanMode: ScanMode = .manual
    public var manualSelect: Bool = false
    public let scanInterval: Double = 2.0
    public let showViewfinder: Bool = false
    public var simulatedData = ""
    public var shouldVibrateOnSuccess: Bool = true
    public var isTorchOn: Bool = false
    public var isGalleryPresented: Binding<Bool>  = .constant(false)
    @Binding var captured: Bool
    public var videoCaptureDevice: AVCaptureDevice? = AVCaptureDevice.bestForVideo
    public var completion: (Result<ScanResult, ScanError>) -> Void


    public func makeUIViewController(context: Context) -> CameraViewController {
        let vc = CameraViewController(showViewfinder: showViewfinder, parentView: self)
        return vc
    }

    public func updateUIViewController(_ uiViewController: CameraViewController, context: Context) {

        uiViewController.completion = self.completion
        uiViewController.parentView = self
        uiViewController.updateViewController(
            isTorchOn: isTorchOn,
            isGalleryPresented: isGalleryPresented.wrappedValue,
            isManualCapture: scanMode == .manual,
            isManualSelect: manualSelect,
            showViewfinder: self.showViewfinder
        )
        if captured {
            uiViewController.captureCamera()
        }
    }

}

@available(macCatalyst 14.0, *)
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(codeTypes: [.qr], captured: Binding(projectedValue: .constant(false))) { result in
            // do nothing
        }
    }
}
