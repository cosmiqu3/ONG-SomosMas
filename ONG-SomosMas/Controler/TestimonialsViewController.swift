//
//  TestimonialsViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class TestimonialsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
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
        
        let api: ONGServiceAPIRest = ONGServiceAPIRest()
        
        api.testimonials(complete: didGetTestimonials)

    }
    
    
    @IBAction func onTapAgregarTestimonio(_ sender: Any) {
    }
    
    
    
    func didGetTestimonials(_ status: Int, _ response : TestimonialsResponse?) {
            print("Callback didGetUserTestimonials")
            print("code    : \(status)")
           // debugPrint(response)
        
        if status == 0 {
            
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
    }
    
    func errorAlertMessage(_ mensaje: String) {
        // create the alert
        let alert = UIAlertController(title: "Error", message: mensaje, preferredStyle: .alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Aceptar", style: UIAlertAction.Style.default, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
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
    
    func getUIColor(hex: String, alpha: Double = 1.0) -> UIColor? {
        var cleanString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cleanString.hasPrefix("#")) {
            cleanString.remove(at: cleanString.startIndex)
        }

        if ((cleanString.count) != 6) {
            return nil
        }

        var rgbValue: UInt32 = 0
        Scanner(string: cleanString).scanHexInt32(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 120
//    }
    
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
