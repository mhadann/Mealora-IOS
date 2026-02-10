//
//  QRScannerView.swift
//  Mealora-IOS
//

import SwiftUI
import AVFoundation

struct QRScannerView: UIViewControllerRepresentable {

    let onScan: (String) -> Void
    @Environment(\.dismiss) private var dismiss

    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .black

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

        // Kamera preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.frame = controller.view.bounds
        previewLayer.videoGravity = .resizeAspectFill
        controller.view.layer.addSublayer(previewLayer)

        // Overlay
        let overlay = UIHostingController(rootView: ScannerOverlayView())
        overlay.view.backgroundColor = .clear
        overlay.view.frame = controller.view.bounds
        controller.addChild(overlay)
        controller.view.addSubview(overlay.view)
        overlay.didMove(toParent: controller)

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


struct ScannerOverlayView: View {

    private let frameSize: CGFloat = 260

    var body: some View {
        ZStack {
            // Mörk bakgrund med hål
            Color.black.opacity(0.55)
                .mask(
                    Rectangle()
                        .overlay(
                            RoundedRectangle(cornerRadius: 24)
                                .frame(width: frameSize, height: frameSize)
                                .blendMode(.destinationOut)
                        )
                )
                .ignoresSafeArea()

            // Scan‑ram
            RoundedRectangle(cornerRadius: 24)
                .stroke(Color.white, lineWidth: 3)
                .frame(width: frameSize, height: frameSize)

            VStack {
                Spacer()

                Text("Placera QR‑koden inom ramen")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
            }
        }
        .compositingGroup()
    }
}
