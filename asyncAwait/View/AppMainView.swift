//
//  ContentView.swift
//  asyncAwait
//
//  Created by Félix Tineo Ortega on 8/6/22.
//

import SwiftUI

struct AppMainView: View {
    
    @StateObject private var modelView = AppModelView()
    
    var body: some View {
        VStack {
            VStack{
                TextField("City Name", text: $modelView.cityName)
                Divider()
            }.padding()
            Button("Check City"){
                modelView.buttonWasTapped()
            }.padding()
                .background(.ultraThinMaterial)
                .foregroundColor(.secondary)
                .cornerRadius(15)
            if modelView.isResultVisible {
                Label {
                    Text("\(modelView.weatherInformation!.name) (\(modelView.weatherInformation!.sys.country)) \(modelView.weatherInformation!.main.temp.description)º")
                } icon: {
                    Image(systemName: "location.fill")
                }.transition(AnyTransition.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .bottom)))

            }
        }.animation(.easeInOut, value: modelView.isResultVisible)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppMainView()
    }
}
