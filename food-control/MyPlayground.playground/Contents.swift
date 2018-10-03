import UIKit

class Meal {
    var name: String
    var happiness: Int
    var items = Array<Item>()
    
    init(name: String, happiness: Int) {
        self.name = name
        self.happiness = happiness
    }
    
    func allCalories() -> Double {
        var total = 0.0
        for i in items {
            total += i.calories
        }
        return total
    }
}

class Item {
    var name: String
    var calories: Double
    
    init(name: String, calories: Double) {
        self.name = name
        self.calories = calories
    }
}

let sanduwich = Meal(name: "Sanduwich X-All", happiness: 5)
print(sanduwich.name)

let item1 = Item(name: "Sanduwich", calories: 115)
let item2 = Item(name: "Salad", calories: 30)
sanduwich.items.append(item1)
sanduwich.items.append(item2)
print(sanduwich.allCalories())

