//
//  LoginViewController.swift
//  ONG-SomosMas
//
//  Created by training on 17-06-22.
//

import UIKit
import Alamofire
class LoginViewController: BaseViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var okLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        bloqueoButton()
    }
    
    func setLogin(){
        let email = emailTextField.text ?? ""
        let pass = passwordTextField.text ?? ""
        
        getLogin(email: email, password: pass)
    }
    
    
    @IBAction func onClick(_ sender: UIButton) {
        setLogin()
    }
    
    func getLogin(email: String, password: String){
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        activityIndicator.startAnimating()
            
        api.login(email: email, password: password, complete: didGetUserLogin)

    }
    
    func didGetUserLogin(_ status : APIStatusType, _ response: LoginResponse?) {
        print("Callback didGetUserLogin")
        print("code    : \(status)")
        if status == .success {
            activityIndicator.stopAnimating()
            successfulAlertMessage("Autentificación éxitosa", complete: didGoToBienvenidos)
        } else {
            activityIndicator.stopAnimating()
            self.okLabel.text = response?.error ?? ""
            errorAlertMessage("Credenciales incorrectas")
        }
    }
    
    func didGoToBienvenidos() {
        print("Callback didGoToBienvenidos")
        self.performSegue(withIdentifier: "segueLoginOk", sender: nil)
    }
    
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextField.text {
            
            if let errorMenssage = invalidEmail(email) {
                emailErrorLabel.text = errorMenssage
                emailErrorLabel.isHidden = false
                LoginButton.isEnabled = true
            }else {
                emailErrorLabel.isHidden = true
                LoginButton.isEnabled = false
            }
        }
        checForValidForm()
    }
    
    
    @IBAction func onTapLogin(_ sender: Any) {
        bloqueoButton()
        setLogin()
    }
    
    @IBAction func passChanged(_ sender: Any) {
        if let name = passwordTextField.text{
            if let errorMessage = invalidoPass(name){
                passwordErrorLabel.text = errorMessage
                passwordErrorLabel.isHidden = false
            }else {
                passwordErrorLabel.isHidden = true
            }
        }
        checForValidForm()
    }
    
    func invalidoPass(_ value: String) ->String?{

        if value == "" {
            return "Favor ingrese Contraseña"
        }
        return nil
    }
    
 
    func bloqueoButton(){
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        
        emailErrorLabel.text = "Requerido"
        passwordErrorLabel.text = "Requerido"
        
        emailErrorLabel.text = ""
        passwordErrorLabel.text = ""
    }
    
    func checForValidForm(){
        if emailErrorLabel.isHidden && passwordErrorLabel.isHidden {
            LoginButton.isEnabled = true
        }else {
            LoginButton.isEnabled = false
        }
    }
    
    func invalidEmail(_ value: String) -> String? {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value) {
            return "Email inválido"
        }
        return nil
    }
}
