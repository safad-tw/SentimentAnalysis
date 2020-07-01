//
//  ReviewTagger.swift
//  SentimentAnalysis
//
//  Practical AI and Machine Learning with Swift Book
//  Copyright © 2020 Mohammad Safad. All rights reserved.
//

import Foundation
import NaturalLanguage
import CoreML

final class ReviewTagger {
    
    private static let shared = ReviewTagger()
    private let scheme = NLTagScheme("Review")
    private let options: NLTagger.Options = [.omitPunctuation]
    
    private lazy var tagger: NLTagger? = {
       
        do {
            guard let modelFile = Bundle.main.url(forResource: "ReviewClassifier", withExtension: "mlmodelc") else {
                return nil
            }
            
            let model = try NLModel(contentsOf: modelFile)
            let tagger = NLTagger(tagSchemes: [scheme])
            tagger.setModels([model], forTagScheme: scheme)
            return tagger
        } catch {
            print(error.localizedDescription)
            return nil
        }
        
    }()
    
    private init() { }
    
    static func prediction(for text: String) -> String? {
        
        guard let tagger = ReviewTagger.shared.tagger else {
            return nil
        }
        
        tagger.string = text
        let range = text.startIndex..<text.endIndex
        tagger.setLanguage(.english, range: range)
        return tagger.tags(in: range, unit: .document, scheme: ReviewTagger.shared.scheme, options: ReviewTagger.shared.options)
                   .compactMap { tag, _ -> String? in
                       return tag?.rawValue
               }.first
    }
    
}
