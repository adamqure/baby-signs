//
//  ContentView.swift
//  Baby Signs
//
//  Created by Adam Ure on 10/28/20.
//

import SwiftUI

struct SignList: View {
    @FetchRequest(
      entity: Sign.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \Sign.name, ascending: true)
      ]
    ) var signs: FetchedResults<Sign>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var addingSign = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(signs, id: \.name) {
                    (sign: Sign) in
                    NavigationLink(sign.name ?? "", destination: ViewSign(name: sign.name!, image: Image(uiImage: UIImage(data: sign.image!)!)))
                }
                .onDelete(perform: deleteSign)
            }
            .sheet(isPresented: $addingSign, content: {
                AddSign() {
                    name, image in
                    addSign(name: name, image: image)
                    self.addingSign = false
                } onCancel: {
                    NSLog("Adding Sign Cancelled")
                    self.addingSign = false
                }
            })
            .navigationTitle(Text("Common Signs"))
            .navigationBarItems(trailing:
                Button(action: {
                    self.addingSign.toggle()
                }) {
                    Image(systemName: "plus")
                        .padding(/*@START_MENU_TOKEN@*/.all, 12.0/*@END_MENU_TOKEN@*/)
                }
            )
        }
        
        
    }
    
    func deleteSign(at offsets: IndexSet) {
        offsets.forEach { index in
            let sign = self.signs[index]
            self.managedObjectContext.delete(sign)
        }
        saveContext()
    }
    
    func addSign(name: String, image: Image) {
        let newSign = Sign(context: managedObjectContext)
        
        newSign.name = name
        newSign.image = image.asUIImage().pngData()
        
        saveContext()
    }
    
    func saveContext() {
      do {
        try managedObjectContext.save()
      } catch {
        print("Error saving managed object context: \(error)")
      }
    }
}

struct SignList_Previews: PreviewProvider {
    static var previews: some View {
        SignList()
    }
}
