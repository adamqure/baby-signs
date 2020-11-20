//
//  AddSign.swift
//  Baby Signs
//
//  Created by Adam Ure on 10/28/20.
//

import SwiftUI

struct AddSign: View {
    static let DefaultName = "Please"
    static let DefaultImage = UIImage(systemName: "plus")
    
    @State var name = ""
    @State var image: Image? = nil
    @State var isShowPicker = false
    let onComplete: (String, Image) -> Void
    let onCancel: () -> Void
    
    var body: some View {
        
        NavigationView {
            VStack {
                Form {
                    Section {
                        if (image == nil) {
                            Button(action: {
                                withAnimation {
                                    self.isShowPicker.toggle()
                                }
                            }, label: {
                                Text("Upload Image")
                            })
                        } else {
                            image?
                                .resizable()
                                .scaledToFit()
                                .frame(height: 320).onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                    withAnimation {
                                        self.isShowPicker.toggle()
                                    }
                                })
                        }
                    }
                    Section {
                        TextField("Sign Name", text: $name)
                            .padding(.horizontal)
                    }
                }.onAppear {
                    UITableView.appearance().backgroundColor = .clear
                }
                Spacer()
                HStack {
                    Spacer()
                    Text("Save").foregroundColor(Color.white).frame(width: nil, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .background(Color.green)
                .cornerRadius(39)
                .padding(.horizontal, 35.0)
                .padding(.bottom, 12.0)
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    savePressed()
                })
                HStack {
                    Spacer()
                    Text("Cancel").foregroundColor(Color.white).frame(width: nil, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    onCancel()
                })
                .background(Color.red)
                .cornerRadius(39)
                .padding([.leading, .bottom, .trailing], 35.0)
            }.sheet(isPresented: $isShowPicker, content: {
                ImagePicker(image: $image)
            })
        }
    }
    
    func savePressed() {
        if let strongImage = self.image {
            onComplete(name, strongImage)
        }
    }
    
    func cancelPressed() {
        onCancel()
    }
}

struct AddSign_Previews: PreviewProvider {
    static var previews: some View {
        AddSign(name: "", image: nil) {
            _, _ in
            print("Preview")
        } onCancel: {
            print("Preview")
        }
    }
}
