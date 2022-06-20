//
//  NewsViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class NewsViewController: UIViewController {
    
    var newsList: [News] = []

    @IBOutlet weak var nameNewsLabel: UILabel!
    
    @IBOutlet weak var descriptionNewsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setup()
    }
    
    func setup() {
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.news(complete: didGetNews)

    }
    
    func didGetNews(_ status: Int, _ response : NewsResponse?) {
        print("Callback didGetNews")
        print("code    : \(status)")
        
        if status == 0 {
            
            guard let cantElements = response?.data.count else {
                errorAlertMessage("No fue posible obtener la lista de Novedades")
                return
            }
            
            if cantElements == 0 {
                
                errorAlertMessage("No se han ingresados Novedades")
                return
            }
            
            response?.data.forEach{ news in
                print("add element to news list")
                print("name: \(news.name)")
                print("description: \(news.content)")
                print("photo: \(news.image)")
                print("")
                newsList.append(News(name: news.name, content: news.content, image: news.image ?? ""))
                
                //newsList[0].
                
                print("cantidad de elementos de news list: \(newsList.count)")
            }
            
            // cargar slider
    

        } else {
            errorAlertMessage("Error al obtener la lista de Novedades")
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
    
    
    @IBAction func onTapQuieroSerParte(_ sender: Any) {
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
