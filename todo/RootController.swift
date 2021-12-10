/**
 * Assignment 5
 * File Name:       RootController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         3.0
 * Date Created:    December 10  2021
 */
import UIKit
import SQLite

class RootController: UITableViewController {
    
    var todos:[Todo] = Db().selectData()
    
    let tableIdentifier = "todosTable"
    let cellSpacingHeight: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
        
        tableView.register(btnTableViewCell.self, forCellReuseIdentifier: "btn")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    override func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let closeAction = UIContextualAction(style: .normal, title:  "Detail", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            if let vc = self.storyboard?.instantiateViewController(identifier: "DetailViewController") as? DetailViewController {
            
                vc.todoId = self.todos[indexPath.row].id
                self.navigationController?.pushViewController(vc, animated: true)
                
            }
            success(true)
        })
        closeAction.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [closeAction])
    }

    override func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let newState: String = (self.todos[indexPath.row].state == "Completed") ? "InProgress" : "Completed"
        let titleForCell = (newState == "Completed") ? "Complete" : "InProgress"
        let modifyAction = UIContextualAction(style: .normal, title: titleForCell, handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            self.todos[indexPath.row].state = newState
            Db().updateState(
                rowid: self.todos[indexPath.row].id,
                isCompletedV: newState == "Completed" ? true : false
            )
            
            tableView.reloadRows(at: [indexPath], with: .none)
//            self.tableView.reloadData()
            success(true)
        })
        
        
        
        modifyAction.backgroundColor = .systemYellow
        
        let modifyAction2 = UIContextualAction(style: .normal, title: "Delete", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            Db().deleteDate( rowid: self.todos[indexPath.row].id )
            self.todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.tableView.reloadData()
            success(true)
        })
        modifyAction2.backgroundColor = .systemRed
        
        return UISwipeActionsConfiguration(actions: [modifyAction2, modifyAction])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row > (todos.count - 1)) {
            
            let btn = tableView.dequeueReusableCell(withIdentifier: "btn", for: indexPath) as! btnTableViewCell
            return btn
            
        }
           
        let cell = tableView.dequeueReusableCell(withIdentifier: tableIdentifier, for: indexPath) as! CustomTableViewCell
               
        let rowData = todos[indexPath.row]
        cell.name = rowData.name
        cell.state = rowData.state
        
        if (rowData.hasDueDate)
        {
            if (rowData.dueDate.timeIntervalSinceReferenceDate < Date().timeIntervalSinceReferenceDate)
            {
                cell.state = "Overdue!"
            } else {
                cell.state = rowData.dueDate.formatted()
            }
        }
        if ( rowData.state == "Completed" )
        {
            cell.state = "Completed"
            cell.nameLabel.textColor = UIColor.gray
            cell.stateLabel.textColor = UIColor.gray
        }
    
        
        // add border and color
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 8
        cell.clipsToBounds = true
                
        return cell
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
            self.todos = db.selectData()
            self.tableView.reloadData()

        }))
        present(alert, animated: false)
    }
    


   

}
