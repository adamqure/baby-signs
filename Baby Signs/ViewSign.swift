//
//  ViewSign.swift
//  Baby Signs
//
//  Created by Adam Ure on 10/28/20.
//

import SwiftUI

struct ViewSign: View {
    
    @State var name = ""
    @State var image: Image? = nil
    @State var isShowPicker = false
//    let onClose: () -> Void

    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
                .frame(height: 320)
            Text(name)
                .fontWeight(.medium)
                .padding(.top, 24.0)
                .font(.system(size: 32
                ))
            Spacer()
        }
    }
}

struct ViewSign_Previews: PreviewProvider {
    static var previews: some View {
        ViewSign(name: "Test", image: Image(systemName: "plus"))
    }
}
