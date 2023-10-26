//
//  QRScannerViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 24/10/2023.
//

import Foundation
import SwiftUI
import AVKit

class QRScannerViewModel: NSObject, ObservableObject, AVCaptureMetadataOutputObjectsDelegate {
    @Published var qrcodeValue:String = ""
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadataObject in metadataObjects {
                    if let qrCodeObject = metadataObject as? AVMetadataMachineReadableCodeObject {
                        if let qrCodeValue = qrCodeObject.stringValue {
                            qrcodeValue = qrCodeValue
                        }
                    }
                }
      }

}
