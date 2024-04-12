//
//  TaskDisplayView.swift
//  ToDo
//
//  Created by LIZZY PEDLEY on 12/04/2024.
//

import Foundation
import SwiftUI

struct TaskDisplayView: View {
    
//    var toDo: ToDoItem
    var toDo: String
    
//    var taskName: String
    
    var body: some View {
        ZStack {
            Color.backgroundColour.edgesIgnoringSafeArea(.all)
                
            VStack {
                Image("todo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)     
//                Text("\(toDo.task)")
//                Text("\(toDo.isComplete)")
//                TextField("To do", text: toDo.task)
//                    .font(.body)
//                    .foregroundColor(.accentColour)
                    Text(toDo)
                
            }
        }
        .background(.backgroundColour)
        .scrollContentBackground(.hidden)
    }
}

//#Preview {
//    TaskDisplayView(toDo: ToDoItem(task: "Test", isComplete: false, detail: ""))
//}

#Preview {
    TaskDisplayView(toDo: "bob")
}
