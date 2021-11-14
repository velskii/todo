
/**
 * Assignment 4
 * File Name:    RootController.swift
 * Author:         FeiliangZhou
 * Student ID:   301216989
 * Version:        1.0
 * Date Created:   November 13  2021
 */
import UIKit

class RootController: UITableViewController {

    var todos =
    [    Todo(name: "First Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(24*60*60*3), state: "in progress"),
         Todo(name: "Second Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-24*60*60*2), state: ""),
         Todo(name: "Third Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-5000), state: ""),
         Todo(name: "Fourth Todo", hasDueDate: false, state: "completed")]
    
    let tableIdentifier = "todosTable"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = tableView.indexPath(for: sender as! UITableViewCell)!
        let listVC = segue.destination as! DetailViewController
        listVC.navigationItem.title = todos[indexPath.row].name
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todos.count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "todo list"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! CustomTableViewCell
               
        let rowData = todos[indexPath.row]
        cell.name = rowData.name
       
        if (rowData.state == "completed")
        {
            cell.state = "completed"
        }
        if (rowData.hasDueDate)
        {
            if (rowData.dueDate.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate)
            {
                cell.state = "Overdue!"
            } else {
                cell.state = rowData.dueDate.formatted()
            }
        }
        return cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath)
//        let rowData = todos[indexPath.row]

//        cell.textLabel?.text = rowData.name
//        if (rowData.state == "completed")
//        {
//            cell.detailTextLabel?.text = "completed"
//        }
//        if (rowData.hasDueDate)
//        {
//            if (rowData.dueDate.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate)
//            {
//                cell.detailTextLabel?.text = "Overdue!"
//            } else {
//                cell.detailTextLabel?.text = rowData.dueDate.formatted()
//            }
//        }
//        return cell
        }

   

}
