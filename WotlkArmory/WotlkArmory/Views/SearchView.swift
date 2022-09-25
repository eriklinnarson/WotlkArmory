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
        NavigationView {
            ZStack {
                HStack {
                    TextField("Character name", text: $searchString)
                    NavigationLink(destination: SearchResultView(searchString: searchString)) {
                        Text("Search")
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarHidden(true)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
