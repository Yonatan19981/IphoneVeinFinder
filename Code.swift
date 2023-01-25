class CameraViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var captureSession: AVCaptureSession!
    var cameraOutput: AVCaptureVideoDataOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var infraredButton: UIButton = {
        let button = UIButton()
        button.setTitle("Infrared", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(enableInfrared), for: .touchUpInside)
        return button
    }()
    var isInfraredEnabled: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup the camera session
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium

        // find the back camera
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)

        // create input for the camera
        do {
            let input = try AVCaptureDeviceInput(device: backCamera!)
            if captureSession.canAddInput(input) {
                captureSession.addInput(input)
            }
        } catch {
            print("Error setting camera input: \(error)")
            return
        }

        // create output for the camera
        cameraOutput = AVCaptureVideoDataOutput()
        cameraOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "cameraQueue"))
        if captureSession.canAddOutput(cameraOutput) {
            captureSession.addOutput(cameraOutput)
        }

        // setup the preview layer
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        previewLayer.frame = view.frame
        view.layer.insertSublayer(previewLayer, at: 0)
        
        // start the camera session
        captureSession.startRunning()

        // add the infrared button
        view.addSubview(infraredButton)
        infraredButton.translatesAutoresizingMaskIntoConstraints = false
        infraredButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        infraredButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }

    @objc func enableInfrared() {
        // code to enable/disable infrared function
        isInfraredEnabled = !isInfraredEnabled
    }

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // handle the video data here
        if isInfraredEnabled {
            // apply infrared filter to the video data
        }
    }
}
