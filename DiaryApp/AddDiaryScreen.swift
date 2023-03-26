//
//  AddDiaryScreen.swift
//  DiaryApp
//
//  Created by Çare C. on 26.03.2023.
//

import SwiftUI

struct AddDiaryScreen: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var title: String = ""
    @State var description: String = ""
    @State var emoji: String = ""
    @State private var showEmojiView = false
    
    var body: some View {
        Form {
            TextField("diary_title", text: $title)
            TextField("diary_description", text: $description)
            Button {
                self.showEmojiView = true
            } label: {
                EmojiLabelView.init(emoji: $emoji)

            }.sheet(isPresented: $showEmojiView, content: {
                EmojiView(txt:$emoji)
            })
//            TextField("emoji", text: $emoji)
        }.navigationBarItems(trailing:
        Button (action: {
            addItem()
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "plus.square")
        })).navigationTitle(Text("add_diary"))
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.title = title
            newItem.detail = description
            newItem.emoji = emoji

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct AddDiaryScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddDiaryScreen()
    }
}
