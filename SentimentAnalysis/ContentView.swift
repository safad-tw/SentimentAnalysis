//
//  ContentView.swift
//  SentimentAnalysis
//
//  Created by Mohammad Safad on 2/24/20.
//  Copyright © 2020 Mohammad Safad. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var text: String = ""
    @State private var isPositive: Bool?
    
    
    var body: some View {
        
        let screenSize = UIScreen.main.bounds
        
        return VStack {
            TextView(text: $text)
                .frame(width: screenSize.width, height: 300)
            Spacer()
            
            (isPositive != nil ? Text(isPositive! ? "😊" : "😞") : Text("")).font(.custom("Arial",size: 100))
            
            Spacer()
    
            Button("Perform Sentiment Analysis") {
               
                if let sentiment = self.text.predictSentiment() {
                    self.isPositive = sentiment == .positive ? true : false 
                }
                
                
            }.padding()
                .background(Color.green)
                .foregroundColor(Color.white)
                .cornerRadius(10)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
