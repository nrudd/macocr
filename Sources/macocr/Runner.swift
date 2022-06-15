//
//  Runner.swift
//  macocr
//
//  Created by Matthias Winkelmann on 13.01.22.
//
import Cocoa
import Vision
import Foundation

@available(macOS 11.0, *)
class Runner {
    static func run(rect: CGRect) -> Int32 {
        let displayID = CGMainDisplayID()

        guard let imgRef = CGDisplayCreateImage(displayID, rect: rect) else {
            fputs("Error: failed to get screenshot", stderr)
            return 1
        }

        let request = VNRecognizeTextRequest { (request, error) in
            let observations = request.results as? [VNRecognizedTextObservation] ?? []
            let obs : [String] = observations.map { $0.topCandidates(1).first?.string ?? ""}
//            try? obs.joined(separator: "\n").write(to: url.appendingPathExtension("md"), atomically: true, encoding: String.Encoding.utf8)

            print(obs.map { "\($0)" }.joined(separator: " "))
        }
        request.recognitionLevel = VNRequestTextRecognitionLevel.accurate // or .fast
        request.usesLanguageCorrection = true
        request.revision = VNRecognizeTextRequestRevision2
        request.recognitionLanguages = ["en"]
        //request.customWords = ["der", "Der", "Name"]

        try? VNImageRequestHandler(cgImage: imgRef, options: [:]).perform([request])
    	return 0
    }
}
