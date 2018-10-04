import Foundation

class Dao {
    
    let mealsArchive: String
    let itemsArchive: String
    
    init() {
        let userDirs = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let dir = userDirs[0]
        mealsArchive = "\(dir)/food-control-meals.dados"
        itemsArchive = "\(dir)/food-control-items.dados"
    }
    
    func save(_ meals: Array<Meal>) {
        NSKeyedArchiver.archiveRootObject(meals, toFile: mealsArchive)
    }
    
    func load() -> Array<Meal>{
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: mealsArchive) {
            return loaded as! Array<Meal>
        }
        return []
    }
    
    func save(_ items: Array<Item>) {
        NSKeyedArchiver.archiveRootObject(items, toFile: itemsArchive)
    }
    
    func load() -> Array<Item>{
        if let loaded = NSKeyedUnarchiver.unarchiveObject(withFile: itemsArchive) {
            return loaded as! Array<Item>
        }
        return []
    }
    
}
