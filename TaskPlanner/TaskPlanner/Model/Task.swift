//
//  Task.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI

// MARK: TaskModel
struct Task: Identifiable{
    var id: UUID = .init()
    var dateAdded: Date
    var taskName: String
    var taskDescription: String
    var taskCategory: Category
}
//var sampleTasks: [Task] = [
//
//    .init(dateAdded: Date(timeIntervalSince1970: 1672829809), taskName: "Task Name 1", taskDescription: "Task Description 1", taskCategory: .general),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Task Name 2", taskDescription: "", taskCategory: .bug),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Task Name 3", taskDescription: "", taskCategory: .challange),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672837009), taskName: "Task Name 4", taskDescription: "", taskCategory: .idea),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Task Name 5", taskDescription: "", taskCategory: .idea),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672901809), taskName: "Task Name 6", taskDescription: "", taskCategory: .idea),
//    .init(dateAdded: Date(timeIntervalSince1970: 1672833409), taskName: "Task Name 7", taskDescription: "", taskCategory: .idea)
//]
