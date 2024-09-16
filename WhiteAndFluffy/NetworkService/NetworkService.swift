//
//  NetworkService.swift
//  WhiteAndFluffy
//
//  Created by Павел Градов on 15.09.2024.
//

import Alamofire

final class NetworkService {
    var parameters : Parameters = [String: Any]()
    var host = String.host
    
    func setupRequest(id: String) {
        host.append(contentsOf: "\(id)/")
        self.parameters = [
            "client_id": Token.accessKey.rawValue,
        ]
    }
    
    func getRequest(completion: @escaping (Result<InfoModel, Error>) -> Void) {
        // guard let photoUrl = url else { return }
        
        // TODO: errors handling
        AF.request(host, method: .get, parameters: parameters).response { response in
            guard response.error == nil else {
                print(response.error!.localizedDescription)
                return
            }
            
            guard let jsonData = response.data else {
                print("Something went wrong with json data")
                return
            }
            
            do {
                let data = try JSONDecoder().decode(InfoModel.self, from: jsonData)
                completion(.success(data))
            } catch {
                completion(.failure(error))
                return
            }
        }
    }
}

enum Token: String {
    case accessKey = "baCvunmA2XzfsRavdVIzhghHURCbr4V073wovijPK-I"
    case secretKey = "NJToujRMGpku0kZEoEVnSY5LHBHvljwcN9ykix_0Yv0"
}

extension String {
    static let host = "https://api.unsplash.com/photos/"
}
