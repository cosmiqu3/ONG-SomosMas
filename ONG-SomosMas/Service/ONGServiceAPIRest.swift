//
//  ONGServiceAPIRest.swift
//  ONG-SomosMas
//
//  Created by training on 15-06-22.
//

import Foundation
import Alamofire

class ONGServiceAPIRest {
    
    // MARK: Properties
    let url_base: String = "https://ongapi.alkemy.org/api"

    
    //MARK: Method Register
    func register(name: String, email: String, password: String, complete : @escaping (_ code: Int, _ messsage: String) -> ()) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "name": name,
            "email": email,
            "password": password
        ]
        
        AF.request("\(url_base)/register", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(1,"se encontró un error")
                return
            }

            guard let data = response.data else {
                complete(2,"sin datos")
                return
            }
            
            do {
                let registryResponse = try JSONDecoder().decode(RegistryResponse.self, from: data)
                print("*** resultado ***\n")
                print("success: \(registryResponse.success ?? false)")
                print("message: \(registryResponse.message)")
                print("errors : \(registryResponse.errors)")
                print("data   : \(registryResponse.data)")
                
                if (registryResponse.success ?? false) {
                    complete(0,registryResponse.message)
                    return
                } else {
                    complete(-1,registryResponse.message)
                    return
                }
               
            } catch let error {
                print(error)
                complete(3,"error al leer contenido")
                return
            }
         }
    }
    
    //MARK: Method Contacts
    func Contacts(nombre: String, correo: String, telefono: String, mensaje: String, complete : @escaping (_ code: Int, _ response : ContactsResponse?) -> ()) {
        
        let headers: HTTPHeaders = [
            "Accept": "application/json"
        ]
        
        let parameters: [String: String] = [
            "name": nombre,
            "email": correo,
            "phone": telefono,
            "message": mensaje
        ]
        
        AF.request("\(url_base)/contacts", method: .post, parameters: parameters, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(1, nil)
                return
            }

            guard let data = response.data else {
                complete(2, nil)
                return
            }
            
            do {
                let contactsResponse = try JSONDecoder().decode(ContactsResponse.self, from: data)
                print("*** resultado ***\n")
                print("success: \(contactsResponse.success ?? false)")
                print("message: \(contactsResponse.message)")
                print("data   : \(contactsResponse.data)")
                
                if (contactsResponse.success ?? false) {
                    complete(0,contactsResponse)
                    return
                } else {
                    complete(-1, nil)
                    return
                }
               
            } catch let error {
                print(error)
                complete(3, nil)
                return
            }
         }
    }
    
    //MARK: Method
    func testimonials(complete : @escaping (_ status: APIStatusType, _ response : TestimonialsResponse?, _ message: String?) -> ()) {
        
        AF.request("\(url_base)/testimonials").response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(.api_call_error, nil, nil)
                return
            }

            guard let data = response.data else {
                complete(.no_data, nil, nil)
                return
            }
            
            do {
                let testimonialsResponse = try JSONDecoder().decode(TestimonialsResponse.self, from: data)
                print("*** resultado ***\n")
                print("success: \(testimonialsResponse.success ?? false)")
                print("message: \(testimonialsResponse.message)")
                print("data   : \(testimonialsResponse.data)")
                
                if (testimonialsResponse.success ?? false) {
                    complete(.success, testimonialsResponse, testimonialsResponse.message)
                    return
                } else {
                    complete(.unsuccessfully,nil, testimonialsResponse.message)
                    return
                }
               
            } catch let error {
                print(error)
                complete(.error_processing_content, nil, nil)
                return
            }
         }
    }
    
    
    //MARK: Method
    func news(complete : @escaping (_ status: Int, _ response : NewsResponse?) -> ()) {
        
        AF.request("\(url_base)/news").response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(1,nil)
                return
            }

            guard let data = response.data else {
                complete(2,nil)
                return
            }
            
            do {
                let newsResponse = try JSONDecoder().decode(NewsResponse.self, from: data)
                print("*** resultado ***\n")
                print("success: \(newsResponse.success ?? false)")
                print("message: \(newsResponse.message)")
                print("data   : \(newsResponse.data)")
                
                if (newsResponse.success ?? false) {
                    complete(0, newsResponse)
                    return
                } else {
                    complete(-1,nil)
                    return
                }
               
            } catch let error {
                print(error)
                complete(3, nil)
                return
            }
         }
    }
    
    //MARK: Method
    func slides(complete : @escaping (_ status: Int, _ response : SlidesResponse?) -> ()) {
        
        AF.request("\(url_base)/slides").response { response in
            
            print ("response:")
            debugPrint(response)
            
            if response.error != nil {
                complete(1,nil)
                return
            }

            guard let data = response.data else {
                complete(2,nil)
                return
            }
            
            do {
                let slidesResponse = try JSONDecoder().decode(SlidesResponse.self, from: data)
                print("*** resultado ***\n")
                print("success: \(slidesResponse.success ?? false)")
                print("message: \(slidesResponse.message)")
                print("data   : \(slidesResponse.data)")
                
                if (slidesResponse.success ?? false) {
                    complete(0, slidesResponse)
                    return
                } else {
                    complete(-1,nil)
                    return
                }
               
            } catch let error {
                print(error)
                complete(3, nil)
                return
            }
         }
    }
}

