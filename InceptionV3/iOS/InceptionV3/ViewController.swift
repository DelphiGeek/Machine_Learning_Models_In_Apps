//
//  ViewController.swift
//  InceptionV3 iOS
//
//  Created by Gregori, Lars on 24.06.18.
//  Copyright © 2018 Gregori, Lars. All rights reserved.
//

import UIKit
import Vision

class ViewController: UIViewController {

    var requests: [VNRequest] = []

    @IBOutlet weak var selectedImage: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            print("model not found")
            return
        }
        let request = VNCoreMLRequest(model: model,
                                  completionHandler: resHandler)
        requests.append(request)
    }

    @IBAction func predict(_ sender: UIButton) {
        selectedImage.image = sender.currentImage
        let image = sender.currentImage!.cgImage!
        let handler = VNImageRequestHandler(cgImage: image,
                                            options: [:])
        try? handler.perform(requests)
    }

    func resHandler(request: VNRequest, _: Error?) {
        guard let results = request.results as? [VNClassificationObservation] else {
            print("request is not a VNClassificationObservation")
            return
        }
        let percent = Int(results[0].confidence * 100)
        let identifier = results[0].identifier
        resultLabel.text = "\(percent)% \(identifier)"
    }

    func resHandler000(request: VNRequest, error: Error?) {

        guard let results = request.results as? [VNClassificationObservation] else {
            return
        }

        print("------------")
        for index in 0..<5 {
            print("\(results[index].identifier) \(results[index].confidence)")
        }

        self.resultLabel.text = "\(Int(results[0].confidence * 100))% \(results[0].identifier)"
        let percent = Int(results[0].confidence * 100)
        let identifier = results[0].identifier
        resultLabel.text = "\(percent)% \(identifier)"
    }

}
