import UIKit

class LoginViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: "logInPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func logInPressed(sender: UIButton) {
        let credentials = (URL: "http://www.skoobr.com/api/users/sign_in", data: ["email": emailField.text!, "password": passwordField.text!])
        Manager.shared.authorizeWithCredentials(credentials) { (status) -> () in

            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                
                if status == 401 {
                    let alert = UIAlertView(title: "Please try again", message: "Wrong email or password", delegate: nil, cancelButtonTitle: "Ok")
                    alert.show()
                } else {
                    let cnvc = CalendarNavigationController()
                    self.presentViewController(cnvc, animated: true, completion: nil)
                }

            })
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
}