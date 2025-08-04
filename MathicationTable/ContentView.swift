//
//  ContentView.swift
//  MathicationTable
//
//  Created by Sougato Roy on 04/08/25.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedTable :Int = 1
    @State private var numberOfQuestions :Int = 5
    @State private var difficulty :String = "Easy"

    var body: some View {
        Text("Mathication Table")
            .font(.title)
            .fontWeight(.heavy)
            .foregroundColor(.white)
            .background(.black)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .frame(width: .infinity, height: 50)
        
        Form{
            Section("Select which multiplication table you want to practice"){
                Picker("Select : ", selection: $selectedTable){
                    ForEach(1..<21, id: \.self){
                        Text("\($0)")
                    }
                }
                .fontWeight(.thin)
            }
            .fontWeight(.bold)
            
            Section("How many questions do you want to be asked?"){
                Stepper("\(numberOfQuestions) questions", value: $numberOfQuestions, in: 5...20, step: 5)
                    .fontWeight(.thin)
            }
            .fontWeight(.bold)
            
            Section("Select difficulty :"){
                Picker("Choose from ", selection: $difficulty){
                    ForEach(["Easy", "Medium", "Hard"], id: \.self){
                        Text($0)
                    }
                }
                .fontWeight(.thin)
            }
            .fontWeight(.bold)
        }
        VStack{
            Button("Proceed"){
                
            }
            .foregroundStyle(.white)
            .frame(width: .infinity, height: 30)
            .padding(.horizontal, 120)
            .background(.orange)
            .clipShape(.capsule)
            
            Section("Quiz Mode"){
                Text("Here we go !")
            }
        }
    }
}

#Preview {
    ContentView()
}
