
/**
 * Assignment 5
 * File Name:       RootController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         2.0
 * Date Created:    November 28  2021
 */
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
    
    func getById(rowid: Int64) -> [Todo]{
        
        do {
            let db = try Connection(path)
            var newItems: [Todo] = []
            for item in try db.prepare(tableResource) {
                
                if (item[id] == rowid) {
                    
                    newItems.append(
                        Todo(
                            id: item[id],
                            name: item[name]!,
                            isCompleted: item[isCompleted],
                            notes: item[notes],
                            hasDueDate: item[hasDueDate],
                            dueDate: item[dueDate],
                            state: "in progress"
                        )
                    )
                    return newItems
                }
            }
        } catch {
            print(error)
        }
//        let item = tableResource.filter(id == rowid)
        return []
        
    }
    
    func selectData() -> [Todo]{
        do {
            let db = try Connection(path)
            
            var newItems: [Todo] = []
            
            for item in try db.prepare(tableResource) {
                print("id: \(item[id]), name: \(item[name]), isCompleted: \(item[isCompleted]), notes: \(item[notes]), hasDueDate: \(item[hasDueDate]), dueDate: \(item[dueDate]) ")
                newItems.append(
                    Todo(
                        id: item[id],
                        name: item[name]!,
                        isCompleted: item[isCompleted],
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
    
    func updateDate(rowid: Int64, nameV: String, isCompletedV: Bool, notesV: String, hasDueDateV: Bool, dueDateV: Date)
    {
        do {
            let db = try Connection(path)
            let item = tableResource.filter(id == rowid)

            try db.run(
                item.update(
                    name <- nameV,
                    isCompleted <- isCompletedV,
                    notes <- notesV,
                    hasDueDate <- hasDueDateV,
                    dueDate <- dueDateV
                )
            )
        } catch {
            print(error)
        }
        
    }
    
    func updateState(rowid: Int64, isCompletedV: Bool)
    {
        do {
            let db = try Connection(path)
            let item = tableResource.filter(id == rowid)

            try db.run(
                item.update(
                    isCompleted <- isCompletedV
                )
            )
        } catch {
            print(error)
        }
        
    }
    
    
    func deleteDate(rowid: Int64) {
        do {
            print("delete id:\(rowid)")
            let db = try Connection(path)
            let item = tableResource.filter(id == rowid)
            try db.run(item.delete())
            
        } catch {
            print(error)
        }
    }
    
    
    
    
    
}
