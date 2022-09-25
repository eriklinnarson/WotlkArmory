//
//  ContentView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

struct SearchResultView: View {
    
    var searchString: String
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.characters, id: \.self) { character in
                    Text(character.server)
                }
            }
            .navigationTitle("Characters")
            .onAppear {
                viewModel.fetchCharacters(searchString: searchString)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchString: "toteman")
    }
}
