//
//  WelcomePageViewController.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import UIKit

class WelcomePageViewController: BaseViewController {

    
    
    @IBOutlet weak var imageUsedUIImage: UIImageView!
    @IBOutlet weak var nameImageLabel: UILabel!
    @IBOutlet weak var descriptionImageLabel: UILabel!
    @IBOutlet weak var nextImageButton: UIButton!
    var thisImage = 0
    var slideList: [Slides] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    func setup() {
        activityIndicator.startAnimating()
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.slides(complete: didGetSlides)

    }
    
    func didGetSlides(_ status: APIStatusType, _ response : SlidesResponse?) {
            print("Callback didGetSlides")
            print("code    : \(status)")
           // debugPrint(response)

        if status == .success {

            guard let cantElements = response?.data.count else {
                errorAlertMessage("No fue posible obtener la lista de Slides")
                return
            }

            if cantElements == 0 {

                errorAlertMessage("No se han ingresados Slides")
                return
            }
            var cantidad: Int = 0
            response?.data.forEach{ slide in
               
                if cantidad < 3 {
                    
                    if slide.id == 1367 || slide.id == 1370 || slide.id == 1381 {
                        
                        if let imageUsed = slide.image {
                            let urlImage = URL(string: imageUsed)
                            if urlImage != nil {
                                if let imageData = try? Data(contentsOf: urlImage!) {
                                    slideList.append( Slides(name: slide.name, content: slide.datumDescription, image: imageUsed, data: imageData) )
                                    cantidad += 1

                                }
                            }
                        }
                    }
                }
                print("add element to news list")
                print("name: \(slide.name)")
                print("description: \(slide.datumDescription)")
                print("photo: \(slide.image)")
                print("")

                print("cantidad de elementos de news list: \(slideList.count)")
             
            }
            
            // cargar slider
            nameImageLabel.text = slideList[thisImage].name
            let descriptionImage = slideList[thisImage].content
            let replaced = descriptionImage.replacingOccurrences(of: "<p>", with: "")
            let replacedDescription = replaced.replacingOccurrences(of: "</p>", with: "")
            descriptionImageLabel.text = replacedDescription
            
            if let loadedImage = UIImage(data: slideList[thisImage].data) {
                imageUsedUIImage.image = loadedImage
            }

        } else {
            errorAlertMessage("Error al obtener la lista de Novedades")
        }
        activityIndicator.stopAnimating()
    }
    

    override func errorAlertMessage(_ mensaje: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }

    
    @IBAction func onTapNextImage(_ sender: Any) {
    
        thisImage += 1
        print("thisImage add: \(thisImage)")
        
        if thisImage >= slideList.count {
            thisImage = 0
        }
        
        if let loadedImage = UIImage(data: slideList[thisImage].data) {
            imageUsedUIImage.image = loadedImage
        }
        nameImageLabel.text = slideList[thisImage].name
        let descriptionImage = slideList[thisImage].content
        let replaced = descriptionImage.replacingOccurrences(of: "<p>", with: "")
        let replacedDescription = replaced.replacingOccurrences(of: "</p>", with: "")
        descriptionImageLabel.text = replacedDescription
        
    
    }
}
