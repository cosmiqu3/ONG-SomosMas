//
//  RegisterViewController.swift
//  ONG-SomosMas
//
//  Created by Training on 16-06-22.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var repeatPasswordErrorLabel: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    
    var emailStatus: Bool = false
    var passwordStatus: Bool = false
    var repeatPasswordStatus: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        restarForm()

    }
    @IBAction func emailChanged(_ sender: Any) {
        if let email = emailTextField.text {
            
            if let errorMenssage = invalidEmail(email) {
                emailErrorLabel.text = errorMenssage
                emailErrorLabel.isHidden = false
                emailStatus = false
            }else {
                emailErrorLabel.isHidden = true
                emailStatus = true
            }
        }
        checkValidForm()
    }
    @IBAction func passwordChanged(_ sender: Any) {
        if let password = passwordTextField.text {
            if let errorMenssage = invalidPassword(password) {
                passwordErrorLabel.text = errorMenssage
                passwordErrorLabel.isHidden = false
                passwordStatus = false
            }else {
                passwordErrorLabel.isHidden = true
                passwordStatus = true
            }
        }
        checkValidForm()
    }
    @IBAction func repeatPasswordChanged(_ sender: Any) {
        if let repeatPassword = repeatPasswordTextField.text {
            if let errorMenssage = invalidRepeatPassword(repeatPassword) {
                repeatPasswordErrorLabel.text = errorMenssage
                repeatPasswordErrorLabel.isHidden = false
                repeatPasswordStatus = false
            }else {
                repeatPasswordErrorLabel.isHidden = true
                repeatPasswordStatus = true
            }
        }
        checkValidForm()
    }
    
    @IBAction func onTapRegister(_ sender: Any) {
        restarForm()
    }
    
    
    func restarForm() {
        registerButton.isEnabled = false
        emailStatus = false
        passwordStatus = false
        repeatPasswordStatus = false
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        repeatPasswordErrorLabel.isHidden = true
        
    }
    
    func checkValidForm() {
        if emailStatus, passwordStatus,  repeatPasswordStatus {
            registerButton.isEnabled = true ///el boton esta habilitado
        }else {
            registerButton.isEnabled = false
        }
    }
    
    func invalidEmail(_ value: String) -> String? {
        let regularExpression = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !predicate.evaluate(with: value) {
            return "Email invalido"
        }
        return nil
    }
    
    func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "La contraseña debe tener al menos 8 caracteres"
        }
        if contaninsDigit(value) {
            return "La contraseña debe tener al menos 1 digito"
        }
        if contaninsLowerCase(value) {
            return "La contraseña debe tener al menos 1 minuscula"
        }
        if contaninsUpperCase(value) {
            return "La contraseña debe tener al menos 1 mayuscula"
        }
        return nil
    }
    func contaninsDigit(_ value: String) -> Bool {
        let regularExpression = ".*[0-9]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func contaninsLowerCase(_ value: String) -> Bool {
        let regularExpression = ".*[a-z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    func contaninsUpperCase(_ value: String) -> Bool {
        let regularExpression = ".*[A-Z]+.*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !predicate.evaluate(with: value)
    }
    
    
    func invalidRepeatPassword(_ value: String) -> String? {
        if repeatPasswordTextField.text != passwordTextField.text{
            return "Las contraseñas deben coincidir"
        }
        return nil
    }
}
