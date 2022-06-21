//
//  RegisterViewController.swift
//  ONG-SomosMas
//
//  Created by Training on 16-06-22.
//

import UIKit

class RegisterViewController: BaseViewController {

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
        //restarForm()
        changeStateRegisterButton(false)
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        if let name = nameTextField.text, let email = emailTextField.text, let password = passwordTextField.text  {
            
            api.register(name: name,
                         email: email,
                         password: password,
                         complete: didGetUserRegister)
        } else {
            changeStateRegisterButton(true)
        }
    }
    
    
    @IBAction func onTapBackLogin(_ sender: Any) {
        didBackLogin()
    }
    
    func didGetUserRegister(status: APIStatusType, messsage: String) {
        
        print("Callback didGetUserRegister")
        print("code    : \(status)")
        print("messsage: \(messsage)")
        
        if status == .success {
            successfulAlertMessage(messsage, complete: didBackLogin)
        } else {
            changeStateRegisterButton(true)
            errorAlertMessage(messsage)
        }
    }
    
    func didBackLogin() {
        
        print("Callback didBackLogin")

        let loginViewController = self.navigationController?.viewControllers.first(where: { viewController in
            if viewController is LoginViewController {
                return true
            } else {
                return false
            }
        })
        if let vController = loginViewController {
            self.navigationController?.popToViewController(vController, animated: true)
        }
    }
    
    func restarForm() {
        changeStateRegisterButton(false)
        
        emailStatus = false
        passwordStatus = false
        repeatPasswordStatus = false
        
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
        repeatPasswordErrorLabel.isHidden = true
        
    }
    
    func changeStateRegisterButton(_ state: Bool) {
        registerButton.isEnabled = state
        if state {
            registerButton.backgroundColor = getUIColor(hex: "#FF0000")
        } else {
            registerButton.backgroundColor = getUIColor(hex: "#CBCBCB")
        }
    }
    
    
    
    func checkValidForm() {
        if emailStatus, passwordStatus,  repeatPasswordStatus {
            changeStateRegisterButton(true) ///el boton esta habilitado
        }else {
            changeStateRegisterButton(false)
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
    
    func invalidPassword(_ value: String) -> String? {
        if value.count < 8 {
            return "La contraseña debe tener al menos 8 caracteres"
        }
        if contaninsDigit(value) {
            return "La contraseña debe tener al menos 1 dígito"
        }
        if contaninsLowerCase(value) {
            return "La contraseña debe tener al menos 1 minúscula"
        }
        if contaninsUpperCase(value) {
            return "La contraseña debe tener al menos 1 mayúscula"
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
