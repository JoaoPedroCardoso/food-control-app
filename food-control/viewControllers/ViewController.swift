import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {

    @IBOutlet var nameField : UITextField?
    @IBOutlet var happinessField : UITextField?
    var delegate : AddMealDelegate?
    var selected = Array<Item>()
    
    var items = [
        Item(name: "Brownie", calories: 10),
        Item(name: "Chocolate frosting", calories: 1000),
        Item(name: "Chocolate chip", calories: 1000),
        Item(name: "Chocolate past", calories: 1200),
        ]
    
    @IBOutlet var tableView : UITableView?
    
    func add(_ item: Item) {
        items.append(item)
        reloadTableData()
    }
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "new item", style: UIBarButtonItem.Style.plain, target: self, action: #selector(showNewItem))
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    @objc func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        nameField!.resignFirstResponder()
        happinessField!.resignFirstResponder()
        
        if let cell = tableView.cellForRow(at: indexPath) {
            if(cell.accessoryType == UITableViewCell.AccessoryType.none) {
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                let item = items[indexPath.row]
                selected.append(item)
            } else {
                cell.accessoryType = UITableViewCell.AccessoryType.none
                let item = items[indexPath.row]
                if let position = selected.index(of: item) {
                    selected.remove(at: position)
                } else {
                    Alert(controller: self).showWarning()
                }
            }
        } else {
            Alert(controller: self).showWarning()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[row]
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:nil)
        cell.textLabel!.text = item.name
        return cell
    }
    
    func getMealFromForm() -> Meal? {
        if let name = nameField?.text {
            if let happiness = convertToInt(happinessField?.text) {
                return Meal(name: name, happiness: happiness, items: selected)
            }
        }
        
        return nil
    }
    
    @IBAction func add() {
        if let meal: Meal = getMealFromForm() {
            if let meals = delegate {
                meals.add(meal)
                if let navigation = navigationController {
                    navigation.popViewController(animated: true)
                } else {
                    Alert(controller: self).showWarning("Unable to go back, but the meal was added.")
                }
                return
            }
        }
        Alert(controller: self).showWarning("Unable to go back, but the meal was added.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
 
    func reloadTableData() {
        tableView?.reloadData()
    }
    
    func convertToInt(_ text: String?) -> Int? {
        if let number = text {
            return Int(number)
        }
        return nil
    }
}
