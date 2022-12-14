//
//  ContentView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

struct SearchResultView: View {
    
    var searchString: String
    @StateObject var viewModel = SearchResultViewModel()
    
    struct Constants {
        static let characterCardHeightScale: CGFloat = 0.11
        static let characterCardPadding: CGFloat = 5
        static let progressViewScaleEffect: CGFloat = GlobalConstants.progressViewScaleEffect
    }
    
    var body: some View {
        if(viewModel.error) {
            Text("No search results for \"\(searchString)\"")
        }
        else if(viewModel.isFetching) {
            VStack {
                Spacer()
                ProgressView()
                    .scaleEffect(Constants.progressViewScaleEffect)
                Spacer()
            }
        }
        else {
            GeometryReader { geometry in
                List {
                    ForEach(viewModel.characters, id: \.self) { character in
                        ZStack {
                            CharacterCardView(character: character)
                            NavigationLink(destination: CharacterDetailsView(characterShortInfo: character)) {
                                EmptyView()
                            }
                            .frame(width: 0)
                            .opacity(0)
                            .padding(0)
                        }
                        .frame(height: geometry.size.height * Constants.characterCardHeightScale)
                        .listRowInsets(.init())
                        .padding(Constants.characterCardPadding)
                    }
                }
                .listStyle(.plain)
                .navigationBarTitle("", displayMode: .inline)
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
