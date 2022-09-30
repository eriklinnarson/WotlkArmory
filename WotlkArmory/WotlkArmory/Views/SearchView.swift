//
//  SearchView.swift
//  WotlkArmory
//
//  Created by Erik Linnarson on 2022-09-25.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchString: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            NavigationView {
                VStack {
                    Image("wotlk_classic_logo")
                        .resizable()
                        .scaledToFit()
                    HStack {
                        Spacer()
                        TextField("Character name", text: $searchString)
                            .fixedSize()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        NavigationLink(destination: SearchResultView(searchString: searchString)) {
                            Image(systemName: "magnifyingglass.circle.fill")
                        }
                        Spacer()
                    }
                    .padding()
                    .font(.title)
                }
                .navigationTitle("Search")
                .navigationBarHidden(true)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
