//
//  Db.swift
//  todo
//
//  Created by Jerry on 2021-11-28.
//

import Foundation
import SQLite


class Db
{
    
    let path = try! FileManager.default
        .url(for: .applicationSupportDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: true
            )
        .appendingPathComponent("test.sqlite").path
    
    let tableResource = Table("mapd714_todo_test2")
    
    let id = Expression<Int64>("id")
    let name = Expression<String?>("name")
    let isCompleted = Expression<Bool>("isCompleted")
    let notes = Expression<String>("notes")
    let hasDueDate = Expression<Bool>("hasDueDate")
    let dueDate = Expression<Date>("dueDate")
    
    init(){
        do {
            let db = try Connection(path)
     
            try db.run(tableResource.create(ifNotExists: true)  {
                t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(isCompleted)
                t.column(notes)
                t.column(hasDueDate)
                t.column(dueDate)
            })
        } catch {
            print(error)
        }
    }
    
    func insertData(nameV: String, isCompletedV: Bool, notesV: String, hasDueDateV: Bool, dueDateV: Date){
        do {
            let db = try Connection(path)
            
            let insert = tableResource.insert(
                name <- nameV,
                isCompleted <- isCompletedV,
                notes <- notesV,
                hasDueDate <- hasDueDateV,
                dueDate <- dueDateV
            )
            let rowid = try db.run(insert)
            print(rowid)
        } catch {
            print(error)
        }
    }
    func selectData() -> [Todo]{
        do {
            let db = try Connection(path)
            
            var newItems: [Todo] = []
            
            for item in try db.prepare(tableResource) {
                print("id: \(item[id]), name: \(item[name]), isCompleted: \(item[isCompleted]), notes: \(item[notes]), hasDueDate: \(item[hasDueDate]), dueDate: \(item[dueDate]) ")
                newItems.append(
                    Todo(
                        name: item[name]!,
                        hasDueDate: true,
                        dueDate: item[dueDate],
                        state: "in progress"
                    )
                )
                
            }
            
            return newItems
        } catch {
            print(error)
        }
        
        return []
    }
    
    
    
    
    
}