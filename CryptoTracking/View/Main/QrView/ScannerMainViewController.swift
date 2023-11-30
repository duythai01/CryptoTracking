//
//  ScannerMainViewController.swift
//  CryptoTracking
//
//  Created by DuyThai on 28/11/2023.
//

import UIKit
import AVFoundation

public class ScannerMainViewController: UIViewController, UINavigationControllerDelegate, UIAdaptivePresentationControllerDelegate {
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var openPhotoLib: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var manualCaptureButton: UIButton!
    @IBOutlet weak var viewFinder: UIImageView!

    private let photoOutput = AVCapturePhotoOutput()
    private var isCapturing = false
    private var handler: ((UIImage) -> Void)?
    private let showViewfinder: Bool
    var parentView: CodeScannerView!
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

    public init(showViewfinder: Bool = false, parentView: CodeScannerView) {
        self.parentView = parentView
        self.showViewfinder = showViewfinder
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.showViewfinder = false
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
        flashButton.setTitle("", for: .normal)
        openPhotoLib.setTitle("", for: .normal)
        manualCaptureButton.setTitle("", for: .normal)

        flashButton.layer.masksToBounds = true
        openPhotoLib.layer.masksToBounds = true
        manualCaptureButton.layer.masksToBounds = true

        flashButton.layer.cornerRadius = flashButton.frame.width / 2
        openPhotoLib.layer.cornerRadius = openPhotoLib.frame.width / 2
        manualCaptureButton.layer.cornerRadius = manualCaptureButton.frame.width / 2
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

        previewLayer.frame = videoView.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(previewLayer)

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

    
    @IBAction func openGalleryFromButton(_ sender: Any) {
        openGallery()
    }

    @IBAction func manualCapturePress(_ sender: Any) {
        self.readyManualCapture()
    }
    @IBAction func flashPressed(_ sender: Any) {
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
    public func updateViewController(isTorchOn: Bool, isGalleryPresented: Bool, isManualCapture: Bool, isManualSelect: Bool) {
        guard let videoCaptureDevice = parentView.videoCaptureDevice ?? fallbackVideoCaptureDevice else {
            return
        }

        if videoCaptureDevice.hasTorch {
            try? videoCaptureDevice.lockForConfiguration()
            videoCaptureDevice.torchMode = isTorchOn ? .on : .off
            videoCaptureDevice.unlockForConfiguration()
        }

        if isGalleryPresented && !isGalleryShowing {
            openGallery()
        }
        manualCaptureButton.isHidden = !isManualCapture
        openPhotoLib.isHidden = !isManualSelect
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

extension ScannerMainViewController: UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isGalleryShowing = false

        if let qrcodeImg = info[.originalImage] as? UIImage {
            let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
            let ciImage = CIImage(image:qrcodeImg)!
            var qrCodeLink = ""

            let features = detector.features(in: ciImage)
            for feature in features as! [CIQRCodeFeature] {
                qrCodeLink = feature.messageString!
                if qrCodeLink == "" {
                    didFail(reason: .badOutput)
                } else {
                    let corners = [
                        feature.bottomLeft,
                        feature.bottomRight,
                        feature.topRight,
                        feature.topLeft
                    ]
                    let result = ScanResult(string: qrCodeLink, type: .qr, image: qrcodeImg, corners: corners)
                    found(result)
                }

            }

        } else {
            print("Something went wrong")
        }

        dismiss(animated: true, completion: nil)
    }

}

extension ScannerMainViewController: AVCaptureMetadataOutputObjectsDelegate {
    public func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            print("@@@: \(stringValue)")

            guard didFinishScanning == false else { return }

            let photoSettings = AVCapturePhotoSettings()
            guard !isCapturing else { return }
            isCapturing = true

            handler = { [self] image in
                let result = ScanResult(string: stringValue, type: readableObject.type, image: image, corners: readableObject.corners)

                switch parentView.scanMode {
                case .once:
                    found(result)
                    // make sure we only trigger scan once per use
                    didFinishScanning = true

                case .manual:
                    if !didFinishScanning, isWithinManualCaptureInterval() {
                        found(result)
                        didFinishScanning = true
                    }

                case .oncePerCode:
                    if !codesFound.contains(stringValue) {
                        codesFound.insert(stringValue)
                        found(result)
                    }

                case .continuous:
                    if isPastScanInterval() {
                        found(result)
                    }
                }
            }
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
}

extension ScannerMainViewController: AVCapturePhotoCaptureDelegate {

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

public extension AVCaptureDevice {
    /// This returns the Ultra Wide Camera on capable devices and the default Camera for Video otherwise.
    static var bestForVideo: AVCaptureDevice? {
        let deviceHasUltraWideCamera = !AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera], mediaType: .video, position: .back).devices.isEmpty
        return deviceHasUltraWideCamera ? AVCaptureDevice.default(.builtInUltraWideCamera, for: .video, position: .back) : AVCaptureDevice.default(for: .video)
    }

}
