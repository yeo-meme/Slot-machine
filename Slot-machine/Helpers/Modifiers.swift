//
//  Modifiers.swift
//  Slot-machine
//
//  Created by yeomim Kim on 2023/01/17.
//

import SwiftUI

struct ShadowModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorTransparentBalck"), radius: 0, x: 0, y:6)
    }
}
