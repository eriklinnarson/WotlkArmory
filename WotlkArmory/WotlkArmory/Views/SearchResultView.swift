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
    
    struct Constants {
        static let characterCardHeightScale: CGFloat = 0.2
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                List {
                    ForEach(viewModel.characters, id: \.self) { character in
                        CharacterCardView(character: character)
                            .listRowSeparator(.hidden)
                            .frame(height: geometry.size.height * Constants.characterCardHeightScale)
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Characters")
                .onAppear {
                    viewModel.fetchCharacters(searchString: searchString)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchString: "toteman")
    }
}
