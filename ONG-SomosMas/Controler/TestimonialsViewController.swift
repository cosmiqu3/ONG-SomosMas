//
//  TestimonialsViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class TestimonialsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var testimonialList: [Testimonial] = []
    
    @IBOutlet weak var testimonialsTableView: UITableView!
    
    func getTestimonialByIndex ( index: Set<Testimonial>.Index) -> Testimonial {
        testimonialList[0]
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup() {
        activityIndicator.startAnimating()
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        api.testimonials(complete: didGetTestimonials)
    }
    
    func didGetTestimonials(_ status: APIStatusType, _ response : TestimonialsResponse?, message: String?) {
            print("Callback didGetUserTestimonials")
            print("code    : \(status)")
           // debugPrint(response)
        
        if status == .success {
            
            guard let cantElements = response?.data.count else {
                errorAlertMessage("No fue posible obtener la lista de Testimonios")
                return
            }
            
            if cantElements == 0 {
                
                errorAlertMessage("No se han ingresados Testimonios")
                return
            }
            
            response?.data.forEach{ tesmn in
                print("add element to testimonial list")
                print("name: \(tesmn.name)")
                print("description: \(tesmn.datumDescription)")
                print("photo: \(tesmn.image)")
                print("")
                testimonialList.append(Testimonial(name: tesmn.name, description: tesmn.datumDescription ?? "", photo: tesmn.image))
            }
            testimonialsTableView.dataSource = self
            //testimonialsTableView.delegate = self
            testimonialsTableView.backgroundColor = .clear
            testimonialsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
            
            testimonialsTableView.reloadData()

        } else {
            errorAlertMessage("Error al obtener la lista de Testimonios")
        }
        activityIndicator.stopAnimating()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testimonialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda:TestimonialsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RowTestimonialsCell", for: indexPath) as! TestimonialsTableViewCell
        
        let testimonialObject = testimonialList[indexPath.row]
        celda.descriptionLabel.text = testimonialObject.description
        celda.nameLabel.text = testimonialObject.name
        //celda.urlImage.inputAccessoryView?.isOpaque = false
        let urlImage = URL(string: testimonialObject.photo)
        if urlImage != nil {
            celda.photoImageView.load(url: urlImage!)
        }
        celda.imageView?.image = UIImage(systemName: testimonialObject.photo)
        celda.backgroundColor = getUIColor(hex: "FFFCDD", alpha: 0.5)
 
        return celda
    }
}
