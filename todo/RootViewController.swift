import UIKit
import Foundation

class RootViewController: UIViewController, UITableViewDataSource
{
    
    @IBOutlet var tableView:UITableView!
   
    var todos =
    [    Todo(name: "First Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(24*60*60*3), state: "in progress"),
         Todo(name: "Second Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-24*60*60*2), state: ""),
         Todo(name: "Third Todo", hasDueDate: true, dueDate: Date().addingTimeInterval(-5000), state: ""),
         Todo(name: "Fourth Todo", hasDueDate: false, state: "completed")]
    
    let tableIdentifier = "todosTable"

    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: tableIdentifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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
    }
}

