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
        
        var testimonial = Testimonial(name: "Juan", description: "Yo", photo: "logoSM.png")
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        testimonialList.append(testimonial)
        
        testimonialsTableView.dataSource = self
        testimonialsTableView.delegate = self
        testimonialsTableView.backgroundColor = .clear
        testimonialsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        
       // self.navigationController?.navigationBar.tintColor = .white
       // self.navigationController?.navigationBar.barTintColor = .white

        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testimonialList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda:TestimonialsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "RowTestimonialsCell", for: indexPath) as! TestimonialsTableViewCell
        
    
        let testimonialObject = testimonialList[indexPath.row]
        
        //var listContentConfiguration = UIListContentConfiguration.cell()
        //listContentConfiguration.º.text = testimonialObject.name
       // listContentConfiguration.description = testimonialObject.description
        
        //listContentConfiguration.image = UIImage(systemName: actvyObject.imagen)
        
        celda.descriptionLabel.text = testimonialObject.description
        celda.nameLabel.text = testimonialObject.name
        celda.nameLabel.inputAccessoryView?.isOpaque = false
        
        celda.imageView?.image = UIImage(systemName: testimonialObject.photo)
        
        
        //celda.contentConfiguration = listContentConfiguration
        celda.backgroundColor = .yellow
      //  celda.tintColor = .white
        
       //s celda.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
//        celda.accessoryType = .none
//
//        let _switch = UIView()
//        _switch.backgroundColor = .yellow
//        _switch.frame = CGRect(x: 0, y: 0, width: 100, height: 90)
//
//        celda.accessoryView = _switch
//
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
