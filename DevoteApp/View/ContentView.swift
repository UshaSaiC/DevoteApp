//
//  ContentView.swift
//  DevoteApp
//
//  Created by Usha Sai Chintha on 19/09/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State var task: String = ""
    @FocusState private var keyboardIsFocused: Bool
    
    private var isButtonDisabled: Bool {
        task.isEmpty
    }
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            newItem.task = task
            newItem.completion = false
            newItem.id = UUID()

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    VStack (spacing: 16) {
                        TextField("New Task", text: $task)
                            .focused($keyboardIsFocused)
                            .padding()
                            .background(
                                Color(UIColor.systemGray6)
                            )
                            .cornerRadius(10)
                        
                        Button (action: {
                            addItem()
                            keyboardIsFocused = false
                            task = ""
                        }, label: {
                            Spacer()
                            Text("Save")
                            Spacer()
                        })
                        .disabled(isButtonDisabled)
                        .padding()
                        .font(.headline)
                        .foregroundColor(.white)
                        .background(isButtonDisabled ? Color.gray : Color.pink)
                        .cornerRadius(10)
                    }
                    .padding()
                    
                    List {
                        ForEach(items) { item in
                                VStack(alignment: .leading) {
                                    Text(item.task ?? "")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    
                                    Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(InsetGroupedListStyle())
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.3), radius: 12)
                    .padding(.vertical, 0)
                    .frame(maxWidth: 640)
                    .scrollContentBackground(.hidden)
                }
            }
            .onAppear(){
                UITableView.appearance().backgroundColor = UIColor.clear
            }
                .navigationBarTitle("Daily Tasks", displayMode: .large)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()

            }
            }
                .background(
                    BackgroundImageView()
                )
                .background(
                    backgroundGradient.ignoresSafeArea(.all)
                )
        }
        .navigationViewStyle(StackNavigationViewStyle()) // it ensure to diplay only a single column at a time
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
