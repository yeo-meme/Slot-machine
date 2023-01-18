//
//  RealView.swift
//  Slot-machine
//
//  Created by yeomim Kim on 2023/01/18.
//

import SwiftUI

struct RealView: View {
    var body: some View {
        Image("gfx-reel")
            .resizable()
            .modifier(ImageModifier())
    }
    
    struct RealView_Previews: PreviewProvider {
        static var previews: some View {
            RealView()
                .previewLayout(.fixed(width: 220, height: 220))
        }
    }
}
