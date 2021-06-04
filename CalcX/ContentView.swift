//
//  ContentView.swift
//  CalcX
//
//  Created by Ostrenkov Nikita on 03.06.2021.
//

import SwiftUI

let primaryColor = Color.init(red: 50/255, green: 50/255, blue: 50/255, opacity: 1.0)
let primaryColor2 = Color.init(red: 220/255, green: 220/255, blue: 220/255, opacity: 1.0)

let rows = [
    ["C", "( )", "%", "÷"],
    ["7", "8", "9", "×"],
    ["4", "5", "6", "−"],
    ["1", "2", "3", "+"],
    ["±", "0", ".", "="]
]


struct ContentView: View {
    @Namespace var ns
    @State var finalValue:String
    @State var resultText:String
    
    init(finalValue: String = "", resultText: String = "0") {
        UITextView.appearance().backgroundColor = .clear
        UITextView.appearance().tintColor = .white
        self.finalValue = finalValue
        self.resultText = resultText
    }
    
    var body: some View {
        
        VStack {
            VStack {
                GeometryReader { metrics in
                    TextEditor(text: $finalValue)
                        .lineLimit(0)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.trailing)
                        .font(.custom("HelveticaNeue", size: 24))
                        .padding(.top, metrics.size.height / 2.0)
                }
                TextField("", text: $resultText)
                    .foregroundColor(Color.gray)
                    .lineLimit(1)
                    .font(.custom("HelveticaNeue", size: 24))
                    .frame(maxWidth: .infinity)
                    .multilineTextAlignment(.trailing)
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, alignment: .topLeading)
            Divider().background(Color.white)
            VStack(spacing: 5) {
                ForEach(rows, id: \.self) { row in
                    HStack(alignment: .center, spacing: 5) {
                        ForEach(row, id: \.self) { column in
                            Button(action: {
                                self.finalValue += column
                                self.resultText = calcResult(exp: finalValue)
                            }, label: {
                                Text(column)
                                    .font(.custom("HelveticaNeue", size: fontSizeByColumn(col: column)))
                                    .lineLimit(0)
                                    .multilineTextAlignment(.center)
                            })
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
                            .foregroundColor(foregroundColorByColumn(col: column))
                            .background(backgroundByColumn(col: column))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        }
                    }
                }
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 400, maxHeight: .infinity, alignment: .center)
        }
        .padding()
        .background(primaryColor)
        .edgesIgnoringSafeArea(.all)
    }
}

func calcResult (exp:String) -> String {
    return "0"
}

func fontSizeByColumn (col:String) -> CGFloat {
    if col == "( )" || col == "%" {
        return 28
    }
    else if  col == "C" || col == "÷" || col == "×" || col == "−" || col == "+" || col == "=" || col == "±"{
        return 28
    }
    return 56
}

func foregroundColorByColumn (col:String) -> Color {
    if col == "C" || col == "( )" || col == "%"  || col == "±" {
        return primaryColor
    }
    return Color.white
}

func backgroundByColumn (col:String) -> Color {
    if col == "÷" || col == "×" || col == "−" || col == "+" || col == "=" {
        return Color.purple
    }
    else if  col == "C" || col == "( )" || col == "%" || col == "±" {
        return primaryColor2
    }
    return Color.gray
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(finalValue: "5+5", resultText: "10")
    }
}
