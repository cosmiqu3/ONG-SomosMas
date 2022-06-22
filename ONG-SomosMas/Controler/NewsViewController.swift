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
    
    let arrayImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"), UIImage(named: "4"), UIImage(named: "5")]
    
    var newsList: [News] = [
        News(name: "Noticia 1", content: "Descripción 1", image: "1"),
        News(name: "Noticia 2", content: "Descripción 2", image: "2"),
        News(name: "Noticia 3", content: "Descripción 3", image: "3"),
        News(name: "Noticia 4", content: "Descripción 4", image: "4"),
        News(name: "Noticia 5", content: "Descripción 5", image: "5")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.news(complete: didGetNews)
        
        photoImageView.image = arrayImages[thisImage]
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        leftButton.isEnabled = false
        
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
    
    @IBAction func onTapLeftButton(_ sender: Any) {
        
        thisImage = thisImage - 1
        if thisImage >= 0 {
            photoImageView.image = arrayImages[thisImage]
        }else {
            leftButton.isEnabled = false
        }
        if thisImage < 0 {
            thisImage = 0
        }
        
        nameNewsLabel.text = newsList[thisImage].name
        descriptionNewsLabel.text = newsList[thisImage].content
        
        paginationPageControl.currentPage = thisImage
    }
    
    
    @IBAction func onTapRightButton(_ sender: Any) {
        
        leftButton.isEnabled = true
        thisImage = thisImage + 1
        if thisImage < arrayImages.count{
            photoImageView.image = arrayImages[thisImage]
        }else {
            thisImage = 0
            photoImageView.image = arrayImages[thisImage]
        }
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
