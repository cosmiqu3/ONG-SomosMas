//
//  ContactoViewController.swift
//  ONG-SomosMas
//
//  Created by training on 16-06-22.
//

import UIKit

class ContactoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var mensageTextField: UITextField!{
        didSet{
            var frame: CGRect = mensageTextField.frame
                frame.size.height = 100
            mensageTextField.frame = frame
            
        }
    }
    
    
    @IBOutlet weak var donarButton: UIButton!{
        didSet{
            donarButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            donarButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            donarButton.layer.shadowOpacity = 1.0
            donarButton.layer.shadowRadius = 2.0
            donarButton.layer.masksToBounds = false
        }
    }
    
    
    @IBOutlet weak var enviarButton: UIButton!{
        didSet{
            enviarButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
            enviarButton.layer.shadowOffset = CGSize(width: 0, height: 3)
            enviarButton.layer.shadowOpacity = 1.0
            enviarButton.layer.shadowRadius = 2.0
            enviarButton.layer.masksToBounds = false
        }
    }

}
