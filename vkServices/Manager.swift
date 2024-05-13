//
//  Manager.swift
//  vkServices
//
//  Created by Cyril Kardash on 13.09.2023.
//

import UIKit

final class Manager {
    
    func loadServices(completion: @escaping ([Service]) -> Void) {
        DispatchQueue.main.async {
            var services = [Service]()
            let urlString = "https://publicstorage.hb.bizmrg.com/sirius/result.json"
            guard let url = URL(string: urlString) else { return }
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {data, responce, error in
                if let error = error {
                    print(error)
                    return
                }
                guard let data = data else { return }
                do {
                    let jsonData = try JSONDecoder().decode(Response.self, from: data)
                    let body = jsonData.body
                    services = body.services
                    completion(services)
                }
                catch {
                    print(error)
                }
            }
            task.resume()
        }
    }
}
