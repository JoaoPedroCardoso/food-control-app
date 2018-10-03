import UIKit

class MealsTableViewController : UITableViewController, AddMealDelegate {
    
    var meals = [
        Meal(name: "Chocolate", happiness: 4, items: [
            Item(name: "Chocolate past", calories: 1200)]),
        Meal(name: "Chocolate's cookie", happiness: 5, items: [
            Item(name: "Chocolate past", calories: 1200),
            Item(name: "Brownie", calories: 10)])
        ]
    
    func add(_ meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addMeal") {
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[row]
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(showDetail))
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier:nil)
        cell.textLabel!.text = meal.name
        cell.addGestureRecognizer(longPressRecognizer)
        
        return cell
    }
    
    @objc func showDetail(recognizer: UILongPressGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizer.State.began) {
            let cell = recognizer.view as! UITableViewCell
            
            if let indexPath = tableView.indexPath(for: cell) {
                let row = indexPath.row
                let meal = meals[row]
                
                RemoveMealController(controller: self).show(meal, handler: { action in
                    self.meals.remove(at: row)
                    self.tableView.reloadData()
                })
            }
            
        }
    }
    
}
