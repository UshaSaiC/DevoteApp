//
//  CheckboxStyle.swift
//  DevoteApp
//
//  Created by Usha Sai Chintha on 21/09/22.
//

import SwiftUI

struct CheckboxStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ?  "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .pink : .primary)
                .font(.system(size: 30, weight: .semibold, design: .rounded))
                .onTapGesture {
                    configuration.isOn.toggle()
                    
                    if configuration.isOn{
                        playSound(sound: "sound-rise", type: "mp3")
                    } else {
                        playSound(sound: "sound-tap", type: "mp3")
                    }
                }
            configuration.label
        }
    }
}

struct CheckboxStyle_Previews: PreviewProvider {
    static var previews: some View {
        Toggle("Placeholder Label", isOn: .constant(false))
            .toggleStyle(CheckboxStyle())
            .padding()
    }
}
