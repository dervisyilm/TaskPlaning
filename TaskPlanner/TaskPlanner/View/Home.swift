//
//  Home.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI

struct Home: View {
    
    @State private var currentDay: Date = .init()
    @State private var tasks: [Task] =  [
        
        .init(dateAdded: Date.now, taskName: "Task Name 1", taskDescription: "Task Description 1", taskCategory: .general),
        .init(dateAdded: Date.now, taskName: "Task Name 2", taskDescription: "", taskCategory: .bug),
        .init(dateAdded: Date.now, taskName: "Task Name 3", taskDescription: "Task Name 3 Description", taskCategory: .challange),
        .init(dateAdded: Date.now, taskName: "Task Name 4", taskDescription: "", taskCategory: .general),
        .init(dateAdded: Date.now, taskName: "Task Name 5", taskDescription: "", taskCategory: .coding),
        .init(dateAdded: Date.now, taskName: "Task Name 6", taskDescription: "", taskCategory: .modifiers),
        .init(dateAdded: Date.now, taskName: "Task Name 7", taskDescription: "", taskCategory: .challange)
    ]
    @State private var addNewTask: Bool = false
    var body: some View {
        
        ScrollView(.vertical, showsIndicators: false){
            TimelineView()
                .padding(15)

        }
        .safeAreaInset(edge: .top, spacing: 0 ){
            HeaderView()
        }
        .fullScreenCover(isPresented: $addNewTask){
            AddNewTask{ task in
                tasks.append(task)
                
            }
        }
    }
    // Timeline View
    @ViewBuilder
    func TimelineView()-> some View{
        ScrollViewReader{ proxy in
            let hours = Calendar.current.hours
            let midHour = hours[hours.count / 2]
            VStack{
                
                ForEach(hours, id: \.self){ hour in
                    TimelineViewRow(hour)
                        .id(hour)
                }
            }
            .onAppear{
                proxy.scrollTo(midHour)
            }
            
        }
    }
    
    // Timeline View Row
    @ViewBuilder
    func TimelineViewRow(_ date: Date)-> some View{
        HStack(alignment: .top){
            Text(date.toString("h a"))
                .poppins(14, .regular)
                .frame(width: 45, alignment: .leading)
            
            let calendar = Calendar.current
            // Filtering Task
            let filteredTask = tasks.filter{
                if let hour = calendar.dateComponents([.hour], from: date).hour,
                    let taskHour = calendar.dateComponents([.hour], from: $0.dateAdded).hour,
                    hour == taskHour && calendar.isDate($0.dateAdded, inSameDayAs: currentDay) {
                        return true
                    }
                return false
                
            }
            if filteredTask.isEmpty{
            
                Rectangle()
                    .stroke(.gray.opacity(0.5), style: StrokeStyle(lineWidth: 0.5, lineCap: .butt, lineJoin: .bevel, dash: [5], dashPhase: 5))
                    .frame(height: 0.5)
                    .offset(y: 10)
                
            }else{
                // Task View
                VStack(spacing: 10){
                    ForEach(filteredTask){ task in
                        TaskRow(task)
                        
                    }
                }
            }
            
        }
        .hAlign(.leading)
        .padding(.vertical, 15)
    }
    
    // Task Row
    
    @ViewBuilder
    func TaskRow(_ task: Task)-> some View{
        
        VStack(alignment: .leading, spacing: 8){
            Text(task.taskName.uppercased())
                .poppins(16, .regular)
                .foregroundColor(task.taskCategory.color)
            
            if task.taskDescription != ""{
                Text(task.taskDescription)
                    .poppins(14, .medium)
                    .foregroundColor(task.taskCategory.color.opacity(0.8))
            }
        }
        .hAlign(.leading)
        .padding(12)
        .background{
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(task.taskCategory.color)
                    .frame(width: 4)
                Rectangle()
                    .fill(task.taskCategory.color.opacity(0.25))
            }
            
        }
    }
    
    // Header View
    @ViewBuilder
    func HeaderView()-> some View{
        VStack{
            HStack{
                VStack(alignment: .leading, spacing: 6) {
                    Text("Today")
                        .poppins(13, .bold)
                    
                    Text("Welcome, iJusting")
                        .poppins(14, .regular)
                }
                .hAlign(.leading)
                
                Button{
                    addNewTask.toggle()
                    
                } label: {
                    HStack(spacing: 10){
                        Image(systemName: "plus")
                        Text("Add Task")
                            .poppins(15, .regular)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background{
                        Capsule()
                            .fill(Color("Blue").gradient)
                    }
                    .foregroundColor(.white)
                }
                
            }
            
            // - Today Date in String
            Text(Date().toString("MMM YYYY"))
                .poppins(16, .medium)
                .hAlign(.leading)
                .padding(.top, 15)
            
            // Current Week Row
            
            WeekRow()
        }
        .padding(15)
        .background{
            VStack(spacing: 0){
                Color.white
                Rectangle()
                    .fill(.linearGradient(colors: [.white, .clear], startPoint: .top, endPoint: .bottom))
                    .frame(height: 20)
            }
            .ignoresSafeArea()
            
        }
    }
    
    // Week Row
    @ViewBuilder
    func WeekRow()-> some View{
        HStack(spacing: 0){
            ForEach(Calendar.current.currentWeek){ weekDay in
                let status = Calendar.current.isDate(weekDay.date, inSameDayAs: currentDay)
                VStack(spacing: 6){
                    Text(weekDay.string.prefix(3))
                        .poppins(12, .medium)
                    Text(weekDay.date.toString("dd"))
                        .poppins(16, status ? .medium : .regular)
                }
                .foregroundColor(status ? Color("Blue"): .gray)
                .hAlign(.center)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)){
                        currentDay = weekDay.date
                    }
                }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, -15)
    }
    
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: View Extensions
extension View {
    func hAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
        
    }
    
    func vAlign(_ alignment: Alignment)-> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
        
    }
}

// MARK: Date Extension
extension Date{
    
    func toString(_ format: String)-> String{
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}

// MARK: Calender Extension
extension Calendar{
    
    // Return 24 Hours in a day
    
    var hours: [Date]{
        let startOfDay = self.startOfDay(for: Date())
        var hours: [Date] = []
        for index in 0..<24{
            if let date = self.date(byAdding: .hour, value: index, to: startOfDay){
                hours.append(date)
                
            }
        }
        return hours
    }
    
    // Returns Current Week in Array Format
    var currentWeek: [WeekDay]{
        guard let firstWeekDay = self.dateInterval(of: .weekOfMonth, for: Date())?.start
                else {return []}
        var week: [WeekDay] = []
        for index in 0..<7{
            if let day = self.date(byAdding: .day, value: index, to: firstWeekDay){
                let weekDaySymbol: String = day.toString("EEEE")
                let isToday = self.isDateInToday(day)
                week.append(.init(string: weekDaySymbol, date: day, isToday: isToday))
            }
        }
        return week
                    
    }
    
    // Used to store data of in each week day
    struct WeekDay: Identifiable{
        var id : UUID = .init()
        var string: String
        var date: Date
        var isToday: Bool = false
    }
}
