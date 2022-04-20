//
//  ContentView.swift
//  Fructus
//
//  Created by skynet on 7/4/22.
//  https://swiftuimasterclass.com

import SwiftUI

struct ContentView: View {
    
    // MARK: - PROPERTIES

    var fruits: [Fruit] = fruitsData

    // MARK: - BODY

    var body: some View {
        NavigationView {
            List {
                ForEach(fruits.shuffled()) { item in
                    NavigationLink(destination: FruitDetailView(fruit: item)) {
                        FruitRowView(fruit: item)
                            .padding(.vertical, 4)
                    }

                }
            }
            .navigationTitle("Fruits")
        }//: NAVIGATION
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(fruits: fruitsData)
            .previewDevice("iPhone 11 Pro")
    }
}
