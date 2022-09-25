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
        static let characterCardHeightScale: CGFloat = 0.11
        static let characterCardPadding: CGFloat = 5
        static let progressViewScaleEffect: CGFloat = 1.5
    }
    
    var body: some View {
        if(viewModel.isFetching) {
            VStack {
                Spacer()
                ProgressView()
                    .scaleEffect(Constants.progressViewScaleEffect)
                Spacer()
            }
        }
        else {
            GeometryReader { geometry in
                NavigationView {
                    List {
                        ForEach(viewModel.characters, id: \.self) { character in
                            CharacterCardView(character: character)
                                .listRowSeparator(.hidden)
                                .frame(height: geometry.size.height * Constants.characterCardHeightScale)
                                .listRowInsets(.init())
                                .padding(Constants.characterCardPadding)
                        }
                    }
                    .listStyle(.plain)
                    .onAppear {
                        viewModel.fetchCharacters(searchString: searchString)
                    }
                }
                .navigationBarTitle("", displayMode: .inline)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView(searchString: "toteman")
    }
}
