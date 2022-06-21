//
//  NewsViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var nameNewsLabel: UILabel!
    
    @IBOutlet weak var descriptionNewsLabel: UILabel!

    
    var thisImage = 0
    
    let arrayImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    
    var newsList: [News] = [
        News(name: "Noticia 1", content: "Descripción 1", image: "1"),
        News(name: "Noticia 2", content: "Descripción 2", image: "2"),
        News(name: "Noticia 3", content: "Descripción 3", image: "3"),
        News(name: "Noticia 4", content: "Descripción 4", image: "4"),
        News(name: "Noticia 5", content: "Descripción 5", image: "5")
    ]
    
    struct Actividad {
        let nombre: String
        let imagen: String
    }
    
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var imageUsedUIImage: UIImageView!
    
    
    @IBAction func onTapLeftButton(_ sender: Any) {
        thisImage = thisImage - 1
        if thisImage >= 0 {
            imageUsedUIImage.image = arrayImages[thisImage]
        }else {
            leftButton.isEnabled = false
        }
        
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
    }
    
    @IBAction func onTapRightButton(_ sender: Any) {
        leftButton.isEnabled = true
        thisImage = thisImage + 1
        if thisImage < arrayImages.count{
            imageUsedUIImage.image = arrayImages[thisImage]
        }else {
            thisImage = 0
            imageUsedUIImage.image = arrayImages[thisImage]
        }
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.news(complete: didGetNews)
        imageUsedUIImage.image = arrayImages[thisImage]
        
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        
        leftButton.isEnabled = false
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
