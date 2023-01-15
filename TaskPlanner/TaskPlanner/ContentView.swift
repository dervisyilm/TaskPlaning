//
//  ContentView.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        Home()
            .preferredColorScheme(.light)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
