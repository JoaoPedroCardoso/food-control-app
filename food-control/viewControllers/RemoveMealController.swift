import UIKit


class RemoveMealController {
    
    let controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func show(_ meal: Meal, handler: @escaping (UIAlertAction) -> Void) {
        let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
        
        let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: handler)
        
        details.addAction(ok)
        details.addAction(remove)
        
        controller.present(details, animated: true, completion: nil)
        
        Alert(controller: controller).showAlert(title: meal.name, message: meal.details())
    }
}
