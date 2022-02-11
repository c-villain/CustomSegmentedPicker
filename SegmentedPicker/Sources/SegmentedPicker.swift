//
//  SegmentedPicker.swift
//  SegmentedPicker
//
//  Created by Alexander Kraev on 10.02.2022.
//

import SwiftUI

public struct SegmentedPicker<Element, Content, Selection>: View
where
Content: View,
Selection: View {
    
    public typealias Data = [Element]
    
    @State private var frames: [CGRect]
    @Binding private var selectedIndex: Data.Index?
    @State var height: CGFloat = 62
    
    private let data: Data
    private let selection: () -> Selection?
    private let content: (Data.Element, Bool) -> Content
    
    public init(_ data: Data,
                selectedIndex: Binding<Data.Index?>,
                @ViewBuilder content: @escaping (Data.Element, Bool) -> Content,
                @ViewBuilder selection: @escaping () -> Selection?) {
        
        self.data = data
        self.content = content
        self.selection = selection
        self._selectedIndex = selectedIndex
        self._frames = State(wrappedValue: Array(repeating: .zero,
                                                 count: data.count))
    }
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: .horizontalCenterAlignment,
                                    vertical: .center)) {
            
            if let selectedIndex = selectedIndex {
                selection()
                RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(.gray.opacity(0.3))
                    .shadow(color: .gray.opacity(0.08),
                            radius: 8,
                            x: 0,
                            y: 3)
                    .frame(width: frames[selectedIndex].width > 0 ? frames[selectedIndex].width - 4 : 0,
                           height: height - 4)
                    .alignmentGuide(.horizontalCenterAlignment) { dimensions in
                        dimensions[HorizontalAlignment.center]
                    }
            }
            
            HStack {
                ForEach(data.indices, id: \.self) { index in
                    Button(action: { selectedIndex = index },
                           label: {
                        HStack {
                            Spacer()
                            content(data[index], selectedIndex == index)
                            Spacer()
                        }
                        .padding(.vertical, 12.0)
                        .frame(height: height)
                        .contentShape(Rectangle())
                    }
                    )
                        .buttonStyle(PlainButtonStyle())
                        .background(GeometryReader { proxy in
                            Color.clear.onAppear { frames[index] = proxy.frame(in: .global) }
                        })
                        .alignmentGuide(.horizontalCenterAlignment,
                                        isActive: selectedIndex == index) { dimensions in
                            dimensions[HorizontalAlignment.center]
                        }
                }
            }
        }
                                    .frame(height: height)
                                    .background(.gray.opacity(0.3))
                                    .cornerRadius(8)
                                    .animation(.easeInOut(duration: 0.3))
    }
}

public extension SegmentedPicker where Selection == EmptyView {
    init(_ data: Data,
         selectedIndex: Binding<Data.Index?>,
         @ViewBuilder content: @escaping (Data.Element, Bool) -> Content)
    {
        self.data = data
        self.content = content
        self.selection = { nil }
        self._selectedIndex = selectedIndex
        self._frames = State(wrappedValue: Array(repeating: .zero,
                                                 count: data.count))
    }
}

struct SegmentedPicker_Previews: PreviewProvider {
    
    struct SegmentedPickerExample: View {
        
        let tabs = ["One", "Two", "Three"]
        @State var selectedIndex: Int? = 0
        
        var body: some View {
            SegmentedPicker(tabs, selectedIndex: $selectedIndex) { tab, isSelected in
                Text(tab)
            }
        }
    }
    
    static var previews: some View {
        SegmentedPickerExample()
            .padding()
            .previewLayout(.sizeThatFits)
    }
}
