//
//  CeldaCollectionViewCell.swift
//  Tablas
//
//  Created by Jorge Maldonado Borbón on 27/11/20.
//

import UIKit

class CeldaCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imagen: UIImageView!

    override func awakeFromNib() {
          print("awakeFromNib")
        imagen.layer.cornerRadius = 10 // Set it how you prefer
        imagen.layer.masksToBounds = true
      }

      override init(frame: CGRect) {
          super.init(frame: frame)
         // self.asCircle()
      }

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        
    }
      
       override var isHighlighted: Bool {
          didSet {
              if isHighlighted {
                  UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                      self.transform = CGAffineTransform(scaleX: 0.5, y: 0.7)
                  }, completion: nil)
              } else {
                  UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
                      self.transform = CGAffineTransform(scaleX: 1, y: 1)
                  }, completion: nil)
              }
          }
      }
}
