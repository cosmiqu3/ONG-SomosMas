//
//  ContactoViewController.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import UIKit

class ContactoViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //Estilo
    @IBOutlet weak var messageTextField: UITextField!{
        didSet{
            var frame: CGRect = messageTextField.frame
                frame.size.height = 100
            messageTextField.frame = frame
            
        }
    }
    @IBOutlet weak var enviarButton: UIButton!{
        didSet{
            enviarButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            enviarButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            enviarButton.layer.shadowOpacity = 1.0
            enviarButton.layer.shadowRadius = 2.0
            enviarButton.layer.masksToBounds = false
        }
    }
    
   
   
    @IBOutlet weak var nameErrorLabel: UILabel!
    
    @IBOutlet weak var telErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    @IBOutlet weak var messageErrorLabel: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bloqueoButton()
    }
 
    
    //Validaciones
    
    func bloqueoButton(){
        enviarButton.isEnabled = false
        nameErrorLabel.isHidden = true
        telErrorLabel.isHidden = true
        emailErrorLabel.isHidden = true
        messageErrorLabel.isHidden = true
        
        nameErrorLabel.text = "Requerido"
        telErrorLabel.text = "Requerido"
        emailErrorLabel.text = "Requerido"
        messageErrorLabel.text = "Requerido"
        
        nameErrorLabel.text = ""
        telErrorLabel.text = ""
        emailErrorLabel.text = ""
        messageErrorLabel.text = ""
        
        
    }
    
    @IBAction func nameTextFiel(_ sender: Any) {
        if let name = nameTextField.text{
            if let errorMessage = invalidoName(name){
                nameErrorLabel.text = errorMessage
                nameErrorLabel.isHidden = false
            }else {
                nameErrorLabel.isHidden = true
            }
            
        }
        checForValidForm()
    }
    
    @IBAction func telTextField(_ sender: Any) {
        
        if let telefono = telTextField.text{
            if let errorMessage = invalidoTel(telefono){
                telErrorLabel.text = errorMessage
                telErrorLabel.isHidden = false
            }else {
                telErrorLabel.isHidden = true
            }
            
        }
       checForValidForm()
    }
    
    @IBAction func mailTextField(_ sender: Any) {
        if let mail = emailTextField.text {
            if let errorMessage = invalidoMail(mail){
                emailErrorLabel.text = errorMessage
                emailErrorLabel.isHidden = false
            }else {
                emailErrorLabel.isHidden = true
            }
            
        }
        checForValidForm()
    }
    
    @IBAction func messageTextField(_ sender: Any) {
        
        if let mensage = messageTextField.text {
            if let errorMessage = invalidoMensaje(mensage){
                messageErrorLabel.text = errorMessage
                messageErrorLabel.isHidden = false
            }else {
                messageErrorLabel.isHidden = true
            }
            
        }
        checForValidForm()
    }
    
    
    
    func invalidoMail(_ value: String) ->String?{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicado = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        if !emailPredicado.evaluate(with: value){
            return "Email Invalido"
        }
        
        return nil
    }
    
    func invalidoMensaje(_ value: String) ->String?{
       
       
        if value == "" {
            return "Favor ingrese mensaje"
        }
        
        return nil
    }
    
    func invalidoName(_ value: String) ->String?{
       
       
        if value == ""{
            return "Favor ingrese Nombre y Apellido"
        }
        
        return nil
    }
    
    func invalidoTel(_ value: String) ->String?{
        let set = CharacterSet(charactersIn: value)
        if !CharacterSet.decimalDigits.isSuperset(of: set){
            return "Numero de telefono solo debe contener numeros"
        }
        
        if value.count != 9{
            return "Numero telefonico debe tener 9 digitos"
        }
        
        return nil
    }
    
    func checForValidForm(){
        if nameErrorLabel.isHidden && telErrorLabel.isHidden && emailErrorLabel.isHidden && messageErrorLabel.isHidden {
            enviarButton.isEnabled = true
        }else {
            enviarButton.isEnabled = false
        }
    }
    
    
    @IBAction func sendAccion(_ sender: Any) {
        
        
       if let nombre = nameTextField.text,
        let correo = emailTextField.text,
        let telefono = telTextField.text,
        let mensaje = messageTextField.text{
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        api.Contacts(nombre: nombre,
                     correo: correo,
                     telefono: telefono,
                     mensaje: mensaje,
                     complete: didGetContacts)
           
           vaciarCampos()
           
       } else {
           bloqueoButton()
       }
    }
    
    func didGetContacts(_ status: APIStatusType, _ response : ContactsResponse?) {
            print("Callback didGetContacts")
            print("status    : \(status)")
            if status == .success {
                successfulAlertMessage(response?.message ?? "")
            } else {
                errorAlertMessage("Se ha producido un error al registrar contacto")
            }
        }
        
    override func successfulAlertMessage(_ mensaje: String) {
            // create the alert
            let alert = UIAlertController(title: "Éxito", message: "Tus datos se han guardado exitosamente", preferredStyle: .alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
        
    override func errorAlertMessage(_ mensaje: String) {
            // create the alert
            let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    
    
    func vaciarCampos(){
        nameTextField.text = ""
        telTextField.text = ""
        emailTextField.text = ""
        messageTextField.text = ""
    }
    
 
    
   

}
