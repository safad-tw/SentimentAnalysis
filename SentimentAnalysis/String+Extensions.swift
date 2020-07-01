//
//  String+Extensions.swift
//  SentimentAnalysis
//
//  Created by Mohammad Safad on 3/23/20.
//  Copyright © 2020 Mohammad Safad. All rights reserved.
//

import Foundation

enum Sentiment: String {
    case positive = "1"
    case negative = "0"
    case neutral = "-1"
}



extension String {
    
    func predictSentiment() -> Sentiment? {
        
        if(self.isEmpty) { return .neutral }
        
        let classString = ReviewTagger.prediction(for: self) ?? ""
        
        return Sentiment(rawValue: classString)
        
    }
    
}
