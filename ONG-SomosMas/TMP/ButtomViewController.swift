//
//  ButtomViewController.swift
//  ONG-SomosMas
//
//  Created by training on 20-06-22.
//

import UIKit

class ButtomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        // Do any additional setup after loading the view.
    }
    
    func didGetSlides(_ status: Int, _ response : SlidesResponse?) {
            print("Callback didGetSlides")
            print("code    : \(status)")
           // debugPrint(response)
        
        if status == 0 {
            
            guard let cantElements = response?.data.count else {
                errorAlertMessage("No fue posible obtener la lista de Slides")
                return
            }
            
            if cantElements == 0 {
                
                errorAlertMessage("No se han ingresados Slides")
                return
            }
            
            response?.data.forEach{ tesmn in
                print("add element to testimonial list")
                print("name: \(tesmn.name)")
                print("description: \(tesmn.datumDescription)")
                print("photo: \(tesmn.image)")
                
                print("")
            }
        } else {
            errorAlertMessage("Error al obtener la lista de Slides")
        }
    }
    
    func errorAlertMessage(_ mensaje: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    

    @IBAction func onTapSlides(_ sender: Any) {
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.slides(complete: didGetSlides)

        
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
