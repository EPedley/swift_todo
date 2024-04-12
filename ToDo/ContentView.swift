//
//  ContentView.swift
//  ToDo
//
//  Created by LIZZY PEDLEY on 09/04/2024.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    struct ToDoItem {
        var task: String
        var isComplete: Bool
        var detail: String
    }
    
    @State var toDoList = [ToDoItem(task: "", isComplete: false, detail: "")]
    
    @State var progress = 0.0
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.backgroundColour.edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("todo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                    
                    ForEach(0..<6) { _ in
                        Spacer()
                    }
                    
                    //                progress view
                    ProgressView(value: progress)
                    
                    List {
                        // incomplete section
                        Section(header: Text("INCOMPLETE TASKS")) {
                            ForEach(toDoList.indices, id: \.self) { index in
                                
                                if toDoList[index].isComplete == false {
                                    HStack {
                                        TextField("To do", text: $toDoList[index].task)
                                            .font(.body)
                                            .foregroundColor(.accentColour)
                                        
                                        //toggle
                                        if $toDoList[index].task.wrappedValue != "" {

                                                Toggle("", isOn: $toDoList[index].isComplete)
                                                    .toggleStyle(CheckboxToggleStyle())
                                                    .onChange(of: toDoList[index].isComplete) { oldValue, newValue in
                                                        updateProgress()
                                                    }
                                                Text("\(toDoList[index])")
                                            NavigationLink(destination: TaskDisplayView(toDo: "pet")) {}
//                                                NavigationLink(destination: TaskDisplayView(task: toDoList[index])) {}
//                                                    .frame(maxWidth: 10)
                                        }
                                    }
                                }
                            }
                            
                            
                            // add button
                            if toDoList.filter { $0.task == "" }.count == 0 {
                                Button(action: {
                                    addNew()
                                })
                                {Image(systemName: "plus.circle")
                                        .foregroundColor(Color.accentColour)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        
                        //                    complete section
                        if toDoList.filter { $0.isComplete == true }.count > 0 {
                            Section(header: Text("COMPLETE TASKS")) {
                                ForEach(toDoList.indices, id: \.self) { index in
                                    if toDoList[index].isComplete == true {
                                        HStack {
                                            Text("\(toDoList[index].task)")
                                                .font(.body)
                                                .foregroundColor(.accentColour)
                                            
                                            Spacer()
                                            
                                            //                                        toggle
                                            Toggle("", isOn: $toDoList[index].isComplete)
                                                .toggleStyle(CheckboxToggleStyle())
                                                .onChange(of: toDoList[index].isComplete) { oldValue, newValue in
                                                    updateProgress()
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .background(.backgroundColour)
                .scrollContentBackground(.hidden)
            }
        }
    }
    
    func addNew() -> Void {
        var incompleteTasks = toDoList.filter { $0.isComplete == false }
        incompleteTasks.append(ToDoItem(task: "", isComplete: false, detail:""))
        toDoList = incompleteTasks + toDoList.filter { $0.isComplete == true }
    }
    
    func updateProgress() -> Void {
        print("UPDATING PROGRESS")
        print(toDoList)
        let completeTasks = toDoList.filter { $0.task != "" && $0.isComplete == true }.count
        let incompleteTasks = toDoList.filter { $0.task != "" && $0.isComplete == false }.count
        let totalTasks = completeTasks + incompleteTasks
        print(completeTasks)
        print(totalTasks)
        progress = Double(completeTasks) / Double(totalTasks)
        print(progress)
    }
    
//    toggle formatting
    struct CheckboxToggleStyle: ToggleStyle {
        func makeBody(configuration: Configuration) -> some View {
            HStack {
     
                RoundedRectangle(cornerRadius: 5.0)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.accentColour)
                    .frame(width: 18, height: 18)
                    .cornerRadius(5.0)
                    .overlay {
                        Image(systemName: configuration.isOn ? "checkmark" : "")
                            .foregroundColor(.accentColour)
                            .font(.system(size:12))
                    }
                    .onTapGesture {
                        withAnimation(.spring()) {
                            configuration.isOn.toggle()
                        }
                    }
     
                configuration.label
     
            }
        }
    }
}



#Preview {
    ContentView()
}
