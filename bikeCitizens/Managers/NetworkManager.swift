//
//  NetworkManager.swift
//  bikeCitizens
//
//  Created by Paul on 27.02.22.
//

import Foundation

let kHOST = "https://api.bikecitizens.net"
let kSEARCH_PATH = "/api/v2/search"

class NetworkManager {

    
    func loadMarks(withName name: String, withCompletion completion: @escaping ([MarkModel]?) -> Void) {
        
        let urlString = "\(kHOST)\(kSEARCH_PATH)?q=\(name)"
        guard let url = URL(string: urlString) else { return }
        loadMarks(withURL: url) { cities in
            completion(cities)
        }
    }
    
    func loadMarks(withURL url: URL, withCompletion completion: @escaping ([MarkModel]?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            let wrapper = try? JSONDecoder().decode(SearchResponse.self, from: data)
            DispatchQueue.main.async {
                completion(wrapper?.data)
            }
        }
        task.resume()
    }
    
}
