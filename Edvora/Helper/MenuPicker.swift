//
//  MenuPicker.swift
//  Edvora
//
//  Created by TeCh_SavVy on 20/04/22.
//
import SwiftUI

@available (iOS 14.0, *)
public struct MenuPicker<T, V: View>: View {
    
    @Binding var selected: Int
    var array: [T]
    var title: String?
    let mapping: (T) -> V
    var callback: (Int) -> ()
    
    public init(selected: Binding<Int>, array: [T], title: String? = nil,
                mapping: @escaping (T) -> V, callback: @escaping (Int) -> ()) {
        self._selected = selected
        self.array = array
        self.title = title
        self.mapping = mapping
        self.callback = callback
    }
    
    public var body: some View {
        if let existingTitle = title {
            HStack {
                Text(existingTitle)
                    .foregroundColor(.primary)
                    .padding(.horizontal)
                menu
            }
        } else {
            menu
        }
    }
    
    var menu: some View {
        Menu(content: {
            ForEach(array.indices, id: \.self) { index in
                Button(action: {
                    selected = index
                    callback(index)
                }, label: {
                    view(for: index)
                })
            }
        }, label: {
            if let item = array[selected]{
                mapping(item)
            }
        })
    }
    
    @ViewBuilder func view(for index: Int) -> some View {
        if selected == index {
            HStack {
                Image(systemName: "checkmark")
                self.mapping(array[index])
            }
        } else {
            self.mapping(array[index])
        }
    }
}
