//
//  RegisterViewController.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let api: ONGServiceAPIRest = ONGServiceAPIRest()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func onTapRegister(_ sender: Any) {
        
        
        api.register(name: "juan prado", email: "juanprado1@gmail.com", password: "123456", complete: didGetUserRegister)
    }
    
    func didGetUserRegister(code: Int, messsage: String) {
            print("Callback didGetUserRegister")
            print("code    : \(code)")
            print("messsage: \(messsage)")
            
            //dependiendo de respuesta agregar logica en ViewController
    }
    
    
    @IBAction func onTabGetTestimonials(_ sender: Any) {
        
        
        api.testimonials(complete: didGetUserTestimonials)
    }
    
    func didGetUserTestimonials(_ status: Int, _ response : TestimonialsResponse?) {
            print("Callback didGetUserTestimonials")
            print("code    : \(status)")
            debugPrint(response)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}