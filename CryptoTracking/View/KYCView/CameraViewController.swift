//
//  CameraViewController.swift
//  CryptoTracking
//
//  Created by DuyThai on 05/12/2023.
//

import Foundation
import AVFoundation
import UIKit
import SwiftUI

public class CameraViewController: UIViewController, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {


    private let photoOutput = AVCapturePhotoOutput()
    private var isCapturing = false
    private var handler: ((UIImage) -> Void)?
    var parentView: CameraView!
    var codesFound = Set<String>()
    var didFinishScanning = false
    var lastTime = Date(timeIntervalSince1970: 0)
    var captureSession: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer!
    let fallbackVideoCaptureDevice = AVCaptureDevice.default(for: .video)

    var completion: ((Result<ScanResult, ScanError>) -> Void)?
    
    override public var prefersStatusBarHidden: Bool {
        true
    }
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .all
    }

    private var isGalleryShowing: Bool = false {
        didSet {
            // Update binding
            if parentView.isGalleryPresented.wrappedValue != isGalleryShowing {
                parentView.isGalleryPresented.wrappedValue = isGalleryShowing
            }
        }
    }

    public init(showViewfinder: Bool = false, parentView: CameraView) {
        self.parentView = parentView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.addOrientationDidChangeObserver()
        self.setBackgroundColor()
        self.handleCameraPermission()
        self.configView()
    }


    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupSession()

    }

    override public func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if (captureSession?.isRunning == true) {
            DispatchQueue.global(qos: .userInteractive).async {
                self.captureSession?.stopRunning()
            }
        }

        NotificationCenter.default.removeObserver(self)
    }

    private func configView() {

    }

    func captureCamera() {
        guard let photoOutputConnection = photoOutput.connection(with: .video) else {
                print("Unable to get connection with video.")
                return
            }

            let photoSettings = AVCapturePhotoSettings()
            photoSettings.flashMode = parentView.videoCaptureDevice?.torchMode == .on ? .on : .off

            photoOutput.capturePhoto(with: photoSettings, delegate: self)
    }

    private func handleCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .restricted:
                break
            case .denied:
                self.didFail(reason: .permissionDenied)
            case .notDetermined:
                self.requestCameraAccess {
                    self.setupCaptureDevice()
                    DispatchQueue.main.async {
                        self.setupSession()
                    }
                }
            case .authorized:
                self.setupCaptureDevice()
                self.setupSession()

            default:
                break
        }
    }


    private func setupSession() {
        guard let captureSession = captureSession else {
            return
        }

        if previewLayer == nil {
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        }

        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)

        reset()

        if (captureSession.isRunning == false) {
            DispatchQueue.global(qos: .userInteractive).async {
                self.captureSession?.startRunning()
            }
        }
    }
    private func setBackgroundColor(_ color: UIColor = .black) {
        view.backgroundColor = color
    }

    private func setupCaptureDevice() {
        captureSession = AVCaptureSession()

        guard let videoCaptureDevice = parentView.videoCaptureDevice ?? fallbackVideoCaptureDevice else {
            return
        }

        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            didFail(reason: .initError(error))
            return
        }

        if (captureSession!.canAddInput(videoInput)) {
            captureSession!.addInput(videoInput)
        } else {
            didFail(reason: .badInput)
            return
        }
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession!.canAddOutput(metadataOutput)) {
            captureSession!.addOutput(metadataOutput)
            captureSession?.addOutput(photoOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = parentView.codeTypes
        } else {
            didFail(reason: .badOutput)
            return
        }
    }
    private func addOrientationDidChangeObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateOrientation),
            name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
            object: nil
        )
    }

    private func requestCameraAccess(completion: (() -> Void)?) {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] status in
            guard status else {
                self?.didFail(reason: .permissionDenied)
                return
            }
            completion?()
        }
    }


    @objc func updateOrientation() {
        guard let orientation = view.window?.windowScene?.interfaceOrientation else { return }
        guard let connection = captureSession?.connections.last, connection.isVideoOrientationSupported else { return }
        switch orientation {
        case .portrait:
            connection.videoOrientation = .portrait
        case .landscapeLeft:
            connection.videoOrientation = .landscapeLeft
        case .landscapeRight:
            connection.videoOrientation = .landscapeRight
        case .portraitUpsideDown:
            connection.videoOrientation = .portraitUpsideDown
        default:
            connection.videoOrientation = .portrait
        }
    }

    func openGallery() {
        isGalleryShowing = true
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.presentationController?.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }


    func openGalleryFromButton() {
        openGallery()
    }

    func manualCapturePress() {
        self.readyManualCapture()
    }
     func flashPressed() {
        guard let videoCaptureDevice = parentView.videoCaptureDevice ?? fallbackVideoCaptureDevice else {
            return
        }
        if videoCaptureDevice.hasTorch {
            try? videoCaptureDevice.lockForConfiguration()
            if videoCaptureDevice.torchMode == .on {
                videoCaptureDevice.torchMode = .off
            } else {
                videoCaptureDevice.torchMode = .on
            }
            videoCaptureDevice.unlockForConfiguration()
        }
    }

    public func updateViewController(isTorchOn: Bool, isGalleryPresented: Bool, isManualCapture: Bool, isManualSelect: Bool, showViewfinder: Bool) {
        guard let videoCaptureDevice = parentView.videoCaptureDevice ?? fallbackVideoCaptureDevice else {
            return
        }
//        print("@@@: updateViewControllerCameraViewController")
        if videoCaptureDevice.hasTorch {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.torchMode = isTorchOn ? .on : .off
            videoCaptureDevice.unlockForConfiguration()
        }

        if isGalleryPresented && !isGalleryShowing {
            openGallery()
        }
    }
    public func reset() {
        codesFound.removeAll()
        didFinishScanning = false
        lastTime = Date(timeIntervalSince1970: 0)
    }

    public func readyManualCapture() {
        guard parentView.scanMode == .manual else { return }
        self.reset()
        lastTime = Date()
    }

    func found(_ result: ScanResult) {
        lastTime = Date()

        if parentView.shouldVibrateOnSuccess {
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }

        parentView.completion(.success(result))
    }

    func didFail(reason: ScanError) {
        parentView.completion(.failure(reason))
    }

    func isPastScanInterval() -> Bool {
        Date().timeIntervalSince(lastTime) >= parentView.scanInterval
    }

    func isWithinManualCaptureInterval() -> Bool {
        Date().timeIntervalSince(lastTime) <= 0.5
    }
}

extension CameraViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isGalleryShowing = false

        dismiss(animated: true, completion: nil)
    }

}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
}

extension CameraViewController: AVCapturePhotoCaptureDelegate {

    public func photoOutput(
        _ output: AVCapturePhotoOutput,
        didFinishProcessingPhoto photo: AVCapturePhoto,
        error: Error?
    ) {
        isCapturing = false
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error while generating image from photo capture data.");
            return
        }
        guard let qrImage = UIImage(data: imageData) else {
            print("Unable to generate UIImage from image data.");
            return
        }
        
        handler?(qrImage)
        parentView.completion(.success(ScanResult(string: "", type: .qr, image: qrImage, corners: [])))
    }

    public func photoOutput(
        _ output: AVCapturePhotoOutput,
        willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings
    ) {
        AudioServicesDisposeSystemSoundID(1108)
    }

    public func photoOutput(
        _ output: AVCapturePhotoOutput,
        didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings
    ) {
        AudioServicesDisposeSystemSoundID(1108)
    }

}
