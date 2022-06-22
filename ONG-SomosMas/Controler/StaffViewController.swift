//
//  StaffViewController.swift
//  ONG-SomosMas
//
//  Created by training on 18-06-22.
//

import UIKit

class StaffViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,
                           UIScrollViewDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
  
    @IBOutlet weak var rolLabel: UILabel!
 
    @IBOutlet weak var descriptionLabel: UILabel!
   
    @IBOutlet weak var stafCollection: UICollectionView!
   
    @IBOutlet weak var pagePhotoPageControl: UIPageControl!
 
    
    var indexStaffImage: Int = 0;
    var maxStaffImage: Int = 8;
    
    var staffList: [Staff] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stafCollection.delegate = self
        stafCollection.dataSource = self
    
        
        staffList.append(Staff(name: "María Irola", role: "Presidenta", description: "María estudió economía y se especializó en economía para el desarrollo. Comenzó como voluntaria en la fundación y fue quien promovió el crecimiento y la organización de la institución acompañando la transformación de un simple comedor barrial al centro comunitario de atención integral que es hoy en día.", image: "staff_mariairola", letterSize: 200, letterPosition: 1200))
        
        staffList.append(Staff(name: "Marita Gomez", role: "Fundadora", description: "Marita estudió la carrera de nutrición y se especializó en nutrición infantil. Toda la vida fue voluntaria en distintos espacios en el barrio hasta que decidió abrir un comedor propio. Comenzó trabajando con 5 familias y culminó su trabajo transformando Somos Más en la organización que es hoy.", image: "staff_maritagomez", letterSize: 30, letterPosition: 190))
        
        staffList.append(Staff(name: "Miriam Rodriguez", role: "Terapista Ocupacional", description: "Terapista Ocupacional.", image: "staff_miriamrodriguez", letterSize: 75, letterPosition: 570))
        
        staffList.append(Staff(name: "Cecilia Mendez", role: "Psicopedagoga", description: "Psicopedagoga.", image: "staff_ceciliamendez", letterSize: 68, letterPosition: 410))
        
        staffList.append(Staff(name: "Mario Fuentes", role: "Psicólogo", description: "Psicólogo.", image: "staff_mariofuentes", letterSize: 75, letterPosition: 420))
        
        staffList.append(Staff(name: "Rodrigo Fuente", role: "Contador", description: "Contador.", image: "staff_rodrigofuente", letterSize: 95, letterPosition: 520))
        
        staffList.append(Staff(name: "Maria Garcia", role: "Profesora de Artes Dramáticas", description: "Profesora de Artes Dramáticas.", image: "staff_mariagarcia", letterSize: 90, letterPosition: 560))
        
        staffList.append(Staff(name: "Marco Fernandez", role: "Profesor de Educación Física", description: "Profesor de Educación Física.", image: "staff_marcofernandez", letterSize: 72, letterPosition: 470))
        
        nameLabel.text  =  staffList[indexStaffImage].name
        rolLabel.text =  staffList[indexStaffImage].role
        descriptionLabel.text = staffList[indexStaffImage].description
        
        
        photoImageView.image =  UIImage(named: staffList[indexStaffImage].image)
        
        photoImageView.contentMode = UIView.ContentMode.scaleAspectFit
        photoImageView.center = self.view.center
        photoImageView.layer.cornerRadius = 25
        photoImageView.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onTapLeftButtom(_ sender: Any) {
        
        indexStaffImage -= 1
        
        if indexStaffImage < 0 {
            indexStaffImage = maxStaffImage - 1
        }
        let indexPath = IndexPath(item: indexStaffImage, section: 0)
        stafCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        stafCollection.delegate?.collectionView!(stafCollection, didSelectItemAt: indexPath)
    }
    
    @IBAction func onTapRightButtom(_ sender: Any) {
        
        indexStaffImage += 1
        
        if indexStaffImage >= maxStaffImage {
            indexStaffImage = 0
        }
        
        let indexPath = IndexPath(item: indexStaffImage, section: 0)
        stafCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        stafCollection.delegate?.collectionView!(stafCollection, didSelectItemAt: indexPath)
    }
    
    
    
    @IBAction func onTapChangeValuePageControl(_ sender: Any) {
        
        indexStaffImage = pagePhotoPageControl.currentPage
        
        nameLabel.text  =  staffList[indexStaffImage].name
        rolLabel.text =  staffList[indexStaffImage].role
        descriptionLabel.text = staffList[indexStaffImage].description
        
        let indexPath = IndexPath(item: indexStaffImage, section: 0)
        stafCollection.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        stafCollection.delegate?.collectionView!(stafCollection, didSelectItemAt: indexPath)
    }
    
    @IBAction func onTapQuieroSerParte(_ sender: Any) {
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return staffList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = stafCollection.dequeueReusableCell(withReuseIdentifier: "cellStaff", for: indexPath) as! CeldaCollectionViewCell
        
        if let imagePhoto = UIImage(named: staffList[indexPath.row].image) {
            
            //cell.photoCollectionImage.image = imagePhoto
            let pointSize = CGPoint(x: 2, y: staffList[indexPath.row].letterPosition)
            let textoImagen: String = staffList[indexPath.row].name
            cell.photoCollectionImage.image = textToImage(drawText: textoImagen as NSString, inImage: imagePhoto, atPoint: pointSize, letra: staffList[indexPath.row].letterSize)
        }
        
        print(staffList[indexPath.row].name)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        pagePhotoPageControl.currentPage = indexPath[1]
        
        let i = indexPath[1]
        nameLabel.text  =  staffList[i].name
        print(nameLabel.text)
        rolLabel.text =  staffList[i].role
        descriptionLabel.text = staffList[i].description
        photoImageView.image =  UIImage(named: staffList[i].image)
    }
}
