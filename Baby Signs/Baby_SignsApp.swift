//
//  Baby_SignsApp.swift
//  Baby Signs
//
//  Created by Adam Ure on 10/28/20.
//

import SwiftUI
import CoreData

@main
struct Baby_SignsApp: App {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Signs")
        container.loadPersistentStores {
            _, error in
            if let error = error as NSError? {
              // You should add your own error handling code here.
              fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
      // 1
      let context = persistentContainer.viewContext
      // 2
      if context.hasChanges {
        do {
          // 3
          try context.save()
        } catch {
          // 4
          // The context couldn't be saved.
          // You should add your own error handling here.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }

    
    
    var body: some Scene {
        let context = persistentContainer.viewContext
        let contentView = SignList().environment(\.managedObjectContext, context)

        WindowGroup {
            contentView
        }
    }
    
    
}
