//
//  NewsViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class NewsViewController: BaseViewController {

    @IBOutlet weak var nameNewsLabel: UILabel!
    
    @IBOutlet weak var descriptionNewsLabel: UILabel!

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var paginationPageControl: UIPageControl!
    
    @IBOutlet weak var leftButton: UIButton!
    
    @IBOutlet weak var rightButton: UIButton!
    
    var thisImage = 0
    
    var newsList: [News] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        
        activityIndicator.startAnimating()
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        api.news(complete: didGetNews)
        paginationPageControl.currentPage = 0
    }
    
    func didGetNews(_ status: APIStatusType, _ response : NewsResponse?) {
        print("Callback didGetNews")
        print("code    : \(status)")
        
        if status == .success {
            guard let cantElements = response?.data.count else {
                errorAlertMessage("No fue posible obtener la lista de Novedades")
                return
            }
            if cantElements == 0 {
                errorAlertMessage("No se han ingresados Novedades")
                return
            }
            
            var cantidad: Int = 0
            response?.data.forEach{ news in
               
                if cantidad < 4 {
                    
                    if news.id == 2091 || news.id == 2092 || news.id == 2144 || news.id == 2151 {
                        
                        if let personImage = news.image {
                            let urlImage = URL(string: personImage)
                            if urlImage != nil {
                                if let imageData = try? Data(contentsOf: urlImage!) {
                                    newsList.append( News(name: news.name, content: news.content, image: personImage, data: imageData) )
                                    cantidad += 1

                                }
                            }
                        }
                    }
                }
                print("add element to news list")
                print("name: \(news.name)")
                print("description: \(news.content)")
                print("photo: \(news.image)")
                print("")

                print("cantidad de elementos de news list: \(newsList.count)")
             
            }
            
            // cargar slider
            nameNewsLabel.text = newsList[thisImage].name
            descriptionNewsLabel.text = newsList[thisImage].content
            
            if let loadedImage = UIImage(data: newsList[thisImage].data) {
                photoImageView.image = loadedImage
            }

        } else {
            errorAlertMessage("Error al obtener la lista de Novedades")
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func onTapLeftButton(_ sender: Any) {
        
        thisImage -= 1
        
        print("thisImage sub: \(thisImage)")
        
        if thisImage < 0 {
            thisImage = newsList.count - 1
        }
        if let loadedImage = UIImage(data: newsList[thisImage].data) {
            photoImageView.image = loadedImage
        }

        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        paginationPageControl.currentPage = thisImage
    }
    
    
    @IBAction func onTapRightButton(_ sender: Any) {

        thisImage += 1
        print("thisImage add: \(thisImage)")
        
        if thisImage >= newsList.count {
            thisImage = 0
        }
        
        if let loadedImage = UIImage(data: newsList[thisImage].data) {
            photoImageView.image = loadedImage
        }
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        
        paginationPageControl.currentPage = thisImage
    }
    
    
    @IBAction func onTapChangeValuePageControl(_ sender: Any) {
        
        let indexImage = paginationPageControl.currentPage
        
        if let loadedImage = UIImage(data: newsList[thisImage].data) {
            photoImageView.image = loadedImage
        }
        nameNewsLabel.text = newsList[indexImage].name
        descriptionNewsLabel.text = newsList[indexImage].content
    }
    
    @IBAction func onTapQuieroSerParte(_ sender: Any) {
    }

}
