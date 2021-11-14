
import UIKit

class FontListViewController: UITableViewController {

    var fontNames: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontNames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell =  tableView.dequeueReusableCell(
            withIdentifier: "FontName",
            for: indexPath)
         
         cell.textLabel?.text = fontNames[indexPath.row]
         cell.detailTextLabel?.text = fontNames[indexPath.row]
         
         return cell
        }



}
