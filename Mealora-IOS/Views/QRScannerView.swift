//
//  QRScannerView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation

import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {

    let onScan: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        let session = AVCaptureSession()

        guard
            let videoDevice = AVCaptureDevice.default(for: .video),
            let videoInput = try? AVCaptureDeviceInput(device: videoDevice),
            session.canAddInput(videoInput)
        else {
            return controller
        }

        session.addInput(videoInput)

        let metadataOutput = AVCaptureMetadataOutput()
        if session.canAddOutput(metadataOutput) {
            session.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(
                context.coordinator,
                queue: DispatchQueue.main
            )
            metadataOutput.metadataObjectTypes = [.qr]
        }

        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = controller.view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        controller.view.layer.addSublayer(previewLayer)

        session.startRunning()
        context.coordinator.session = session

        return controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onScan: onScan, dismiss: dismiss)
    }

    final class Coordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
        let onScan: (String) -> Void
        let dismiss: DismissAction
        var session: AVCaptureSession?

        init(onScan: @escaping (String) -> Void, dismiss: DismissAction) {
            self.onScan = onScan
            self.dismiss = dismiss
        }

        func metadataOutput(
            _ output: AVCaptureMetadataOutput,
            didOutput metadataObjects: [AVMetadataObject],
            from connection: AVCaptureConnection
        ) {
            guard
                let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
                let value = object.stringValue
            else { return }

            session?.stopRunning()
            onScan(value)
            dismiss()
        }
    }
}
