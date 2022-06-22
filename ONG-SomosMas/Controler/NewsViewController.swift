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
    
    let arrayImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4")]
    
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
        
        photoImageView.image = arrayImages[thisImage]
//        nameNewsLabel.text = newsList[thisImage].name
//        descriptionNewsLabel.text = newsList[thisImage].content
        
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
                    
                    if news.id == 2091 || news.id == 2092 || news.id == 2144 || news.id == 2145 {
                        cantidad += 1
                        newsList.append( News(name: news.name, content: news.content, image: news.image ?? "") )
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

        } else {
            errorAlertMessage("Error al obtener la lista de Novedades")
        }
        activityIndicator.stopAnimating()
    }
    
    @IBAction func onTapLeftButton(_ sender: Any) {
        
        thisImage -= 1
        
        print("thisImage sub: \(thisImage)")
        
        if thisImage < 0 {
            thisImage = arrayImages.count - 1
        }
        photoImageView.image = arrayImages[thisImage]

        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        paginationPageControl.currentPage = thisImage
    }
    
    
    @IBAction func onTapRightButton(_ sender: Any) {

        thisImage += 1
        print("thisImage add: \(thisImage)")
        
        if thisImage >= arrayImages.count {
            thisImage = 0
        }
        
        photoImageView.image = arrayImages[thisImage]
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        
        paginationPageControl.currentPage = thisImage
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
