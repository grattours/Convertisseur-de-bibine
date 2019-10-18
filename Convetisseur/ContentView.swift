//
//  ContentView.swift
//  Convetisseur
//
//  Created by Luc Derosne on 17/10/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var bibineUnits = ["Galopin", "Demi", "Pinte", "Chopine", "Formidable", "Sérieux", "Girafe"]
    //var tempoCentils = ["12,5",   "25,0",  "50,0",   "58,8",     "1000",       "2000",   "2500"]
    //  Galopin, Demi, Pinte, Chopine, Formidable, Sérieux, Girafe
    var toCentilsClosures: [(Double) -> Double] = [
    { $0 * 12.5 }, { $0 * 25 }, { $0 * 50 }, { $0 * 58.8 }, { $0 * 1000 }, { $0 * 2000 }, { $0 * 2500 } ]
    var fromCentilsClosures: [(Double) -> Double] = [{ $0 / 12.5 }, { $0 / 25 }, { $0 / 50 }, { $0 / 58.8 }, { $0 / 1000 }, { $0 / 2000 }, { $0 / 2500 } ]
    
    @State private var input = ""
    @State private var selectUnitIn = 0
    @State private var selectUnitOut = 1
    @State private var typeConversion  = 0
    
    
    var output: Double {
        guard let input = Double(input) else { return 0 }
        let toCentils = toCentilsClosures[selectUnitIn]
        let fromCentils = fromCentilsClosures[selectUnitOut]
        return fromCentils(toCentils(input))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Quantité à convertir")) {
                    TextField("Saisir la quantité : ", text: $input)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("Selectionner l'unité à convertir : ")) {
                    Picker("Unité d'origine", selection: $selectUnitIn) {
                        ForEach(0 ..< self.bibineUnits.count) { id in
                            Text("\(self.bibineUnits[id])")
                        }
                    }//.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Selectioner l'unité cible : ")) {
                    Picker("Unité de sortie", selection: $selectUnitOut) {
                        ForEach(0 ..< self.bibineUnits.count) { id in
                            Text("\(self.bibineUnits[id])")
                        }
                    }//.pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Quantité convertie")) {
                    Text("\(output)")
                }
                
            }.navigationBarTitle(Text("Convertisseur de Bibine"))
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
