//
//  DemoPickerSegment.swift
//  SegmentedPicker
//
//  Created by Alexander Kraev on 10.02.2022.
//

import SwiftUI

struct DemoPickerSegment: View {
    
    @State var title: String
    @State var desc: String
    
    var body: some View {
        VStack(spacing: 4.0) {
            Text(title)
                .kerning(0.3)
                .fixedSize()
                .foregroundColor(.black)
                .font(.title2)
            if (!desc.isEmpty) {
                    Text(desc)
                    .foregroundColor(.gray)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .allowsTightening(true)
            }
        }
        .frame(height: 62.0)
    }
}
