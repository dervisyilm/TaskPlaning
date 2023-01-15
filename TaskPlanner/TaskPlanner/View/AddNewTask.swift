//
//  AddNewTask.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI

struct AddNewTask: View {
    // Callback
    var onAdd: (Task)->()
    
    // View Properties
    @Environment(\.dismiss) private var dismiss
    @State private var taskName: String = ""
    @State private var taskDescription: String = ""
    @State private var taskDate: Date = .init()
    @State private var taskCategory: Category = .general
    
    // Category Animation Properties
    @State private var animateColor: Color = Category.general.color
    @State private var animate: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
        
            VStack(alignment: .leading, spacing: 10){
         
                Button{
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .contentShape(Rectangle())
                }
                Text("Create New Task")
                    .poppins(28, .bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 15)
                
                TitleView("NAME")
                TextField("Make New Swift App", text: $taskName)
                    .poppins(15, .regular)
                    .tint(.white)
                    .padding(.top, 2)
                
                Rectangle()
                    .fill(.white.opacity(0.7))
                    .frame(height: 1)
                
                TitleView("DATE")
                    .padding(.top, 15)
                
                HStack(alignment: .bottom, spacing: 12){
                    HStack(spacing: 12){
                        Text(taskDate.toString("EEEE dd, MMMM"))
                            .poppins(16, .regular)
                        
                        Image(systemName: "calendar")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: [.date])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    
                    HStack(spacing: 12){
                        Text(taskDate.toString("hh:mm a"))
                            .poppins(16, .regular)
                        
                        Image(systemName: "clock")
                            .font(.title3)
                            .foregroundColor(.white)
                            .overlay{
                                DatePicker("", selection: $taskDate, displayedComponents: [.hourAndMinute])
                                    .blendMode(.destinationOver)
                            }
                    }
                    .offset(y: -5)
                    .overlay(alignment: .bottom){
                        Rectangle()
                            .fill(.white.opacity(0.7))
                            .frame(height: 1)
                            .offset(y: 5)
                    }
                    
                    
                }
                .padding(.bottom, 15)
                
            }
            .environment(\.colorScheme, .dark)
            .hAlign(.leading)
            .padding(15)
            .background{
                ZStack{
                    taskCategory.color
                    GeometryReader{
                        let size = $0.size
                        Rectangle()
                            .fill(animateColor)
                            .mask{
                                Circle()
                            }
                            .frame(width: animate ? size.width * 2 : 0, height: animate ? size.height * 2 : 0)
                            .offset(animate ? CGSize(width: -size.width / 2, height: -size.height / 2) : size)
                    }
                    .clipped()
                }
                .ignoresSafeArea()
            }
            
            VStack(alignment: .leading, spacing: 10){
                TitleView("DESCRIPTION", .gray)
                TextField("About your Task", text: $taskDescription)
                    .poppins(16, .regular)
                    .padding(.top, 2)
                Rectangle()
                    .fill(.black.opacity(0.2))
                    .frame(height:1)
                TitleView("CATEGORY", .gray)
                    .padding(.top, 15)
                
                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 20), count: 3), spacing: 15){
                    ForEach(Category.allCases, id: \.rawValue){ category in
                        Text(category.rawValue.uppercased())
                            .poppins(12, .regular)
                            .hAlign(.center)
                            .padding(.vertical, 5)
                            .background{
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(category.color.opacity(0.25))
                            }
                            .foregroundColor(category.color)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                guard !animate else {return}
                                animateColor = category.color
                                withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 1, blendDuration: 1)){
                                    animate = true
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                                    animate = false
                                    taskCategory = category
                                }
                            }
                    }
                }
                .padding(.top, 5)
                
                Button {
                    
                    // Creating Task and pass it to the callback
                    let task = Task(dateAdded: taskDate, taskName: taskName, taskDescription: taskDescription, taskCategory: taskCategory)
                    onAdd(task)
                    dismiss()
                    
                } label: {
                    Text("Create Task")
                        .poppins(16, .regular)
                        .foregroundColor(.white)
                        .padding(.vertical, 15)
                        .hAlign(.center)
                        .background{
                            Capsule()
                                .fill(animateColor.gradient)

                        }
                }
                .vAlign(.bottom)
                .disabled(taskName == "" || animate)
                .opacity(taskName == "" ? 0.6 : 1)
            }
            .padding(15)
            
        }
        .vAlign(.top)
    }
    
    @ViewBuilder
    func TitleView(_ value: String, _ color: Color = .white.opacity(0.7))-> some View{
        Text(value)
            .poppins(12, .regular)
            .foregroundColor(color)
    }
    
}

struct AddNewTask_Previews: PreviewProvider {
    static var previews: some View {
        AddNewTask{ task in
            
        }
    }
}
