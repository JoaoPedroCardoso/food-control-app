import UIKit

class Alert {
    
    let controller: UIViewController
    
    init(controller: UIViewController){
        self.controller = controller
    }
    
    func showAlert(title: String = "Alert", message: String, cancelButtonName: String = "OK") {
        let details = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: cancelButtonName, style: UIAlertAction.Style.cancel, handler: nil)
        
        details.addAction(ok)
        controller.present(details, animated: true, completion: nil)
    }
    
    func showWarning(_ message: String = "Unexpected error.") {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let ok = UIAlertAction(title: "Understood", style: UIAlertAction.Style.cancel, handler: nil)
        
        alert.addAction(ok)
        controller.present(alert, animated: true, completion: nil)
    }
}
