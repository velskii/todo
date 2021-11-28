
/**
 * Assignment 5
 * File Name:    RootController.swift
 * Author:         FeiliangZhou
 * Student ID:   301216989
 * Version:        1.0
 * Date Created:   November 13  2021
 */
import UIKit
import SQLite

class RootController: UITableViewController {
    
    var todos:[Todo] = []
//    var todos =
//    [
//        Todo(name: "First Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(24*60*60*3), state: "in progress"),
//         Todo(name: "Second Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-24*60*60*2), state: ""),
//         Todo(name: "Third Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-5000), state: ""),
//         Todo(name: "Fourth Todo", hasDueDate: false, state: "completed"),
//    ]
    
    let tableIdentifier = "todosTable"
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        let list = Db().selectData()
        todos = list
        
        
        super.viewDidLoad()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        
        tableView.register(btnTableViewCell.self, forCellReuseIdentifier: "btn")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return  1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return todos.count + 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
         return "Todo list"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80)
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    
    // this method handles row deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            if editingStyle == .delete {

                // remove the item from the data model
                todos.remove(at: indexPath.row)

                // delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
                self.tableView.reloadData()

            } else if editingStyle == .insert {
                
            }
        }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row > (todos.count - 1)) {
            
            let btn = tableView.dequeueReusableCell(withIdentifier: "btn", for: indexPath) as! btnTableViewCell
            return btn
            
        }
           
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
        
        cell.editButton.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        cell.editButton.tag = indexPath.row
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
                
        return cell
    }
    
    @objc func pressButton(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        if (indexPath.row > (todos.count - 1)) {
            NewData()

        }
    }
  
    @objc private func NewData()
    {
        let alert = UIAlertController(title: "Enter name", message: "", preferredStyle: .alert)
        alert.addTextField{field in
            field.placeholder = ""
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let name = alert?.textFields![0].text

            let db = Db()
            db.insertData(
                nameV: name!,
                isCompletedV: false,
                notesV: "nothing yet",
                hasDueDateV: true,
                dueDateV: Date().addingTimeInterval(24*60*60)
            )
            self.todos.append(
                Todo(name: name!,
                     hasDueDate: true,
                     dueDate: Date().addingTimeInterval(24*60*60),
                     state: "InProgress"
                    )
            )
            self.tableView.reloadData()

        }))
        present(alert, animated: false)
    }
          

   

}
