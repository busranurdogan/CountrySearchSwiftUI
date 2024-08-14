
import Foundation
import SwiftUI

class Network: ObservableObject {
    @Published var countries: [Country] = []
    
    func getCountries() {
        guard let url = URL(string: "https://restcountries.com/v3.1/all") else { fatalError("Missing URL") }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedCountries = try JSONDecoder().decode([Country].self, from: data)
                        self.countries = decodedCountries
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
