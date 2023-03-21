//
//  InfoView.swift
//  Slot-machine
//
//  Created by yeomim kim on 2023/03/13.
//

import SwiftUI

struct InfoView: View {
    //클로즈 버튼 작통 모드 button action
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
        
            Form {
                Section(header:Text("About the application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                }
            }
            .font(.system(.body, design: .rounded))
        }
        .padding(.top, 40)
        .overlay(
         Button(action: {
             audioPlayer?.stop()
             //actiopn
             self.presentationMode.wrappedValue.dismiss()
         }) {
             Image(systemName: "xmark.circle")
                 .font(.title)
         }
            .padding(.top, 30)
            .padding(.trailing, 20)
            .accentColor(Color.secondary)
         , alignment: .topTrailing
         )
        .onAppear(perform: {
            playSound(sound: "background-music", type: "mp3")
        })
    }
}

struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack {
            Text(firstItem).foregroundColor(Color.gray)
            Spacer()
            Text(secondItem)
        }
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
