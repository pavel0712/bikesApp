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

    func loadMarks(withName name: String, withCompletion completion: @escaping ([MarkModel]) -> Void) {
        
        let urlString = "\(kHOST)\(kSEARCH_PATH)?q=\(name)"
        guard let url = URL(string: urlString) else { return }
        loadMarks(withURL: url) { cities in
            completion(cities)
        }
    }
    
    private func loadMarks(withURL url: URL, withCompletion completion: @escaping ([MarkModel]) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let responseData = data else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            let wrapper = try? JSONDecoder().decode(SearchResponse.self, from: responseData)
            guard let marks = wrapper?.data else {
                DispatchQueue.main.async { completion([]) }
                return
            }
            DispatchQueue.main.async {
                completion(marks)
            }
        }
        task.resume()
    }
    
}
