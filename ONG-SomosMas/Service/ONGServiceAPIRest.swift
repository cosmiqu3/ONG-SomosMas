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

    
    //MARK: Method
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
                } else {
                    complete(-1,registryResponse.message)
                }
               
            } catch let error {
                print(error)
                complete(3,"error al leer contenido")
            }
         }
    }
}

