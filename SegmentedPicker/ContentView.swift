//
//  ContentView.swift
//  SegmentedPicker
//
//  Created by Alexander Kraev on 10.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var titles: [String : String] = ["Title 1" : "Subtitle 1", "Title 2": "Subtitle 2", "Title 3": "Subtitle 3"]
    
    @State var selectedIndex: Int = 0
    
    var body: some View {
        setPicker(titles: Array(titles.keys))
            .padding()
    }
    
    @ViewBuilder
    private func getSegment(_ title: String) -> some View {
        DemoPickerSegment(title: title, desc: titles[title] ?? "")
    }
    
    @ViewBuilder
    private func setPicker(titles: [String]) -> some View {
        SegmentedPicker(
            titles,
            selectedIndex: Binding(
                get: { selectedIndex },
                set: {
                    selectedIndex = $0 ?? 0
                }),
            content: { title, isSelected in
                getSegment(title)
            }
        )

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
