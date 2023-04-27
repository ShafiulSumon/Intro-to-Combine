//
//  CombinePractice.swift
//  Intro-to-combine
//
//  Created by ShafiulAlam-00058 on 4/12/23.
//

import UIKit
import Combine

class Repository: Codable {
    var name: String
    var url : URL
}

class CombinePractice: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    var cancellable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "https://api.github.com/repos/johnsundell/publish") else {
            return
        }
        let publisher = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Repository.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
        
        cancellable = publisher
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    print("success!")
                case .failure(let error):
                    self?.errorLabel.text = error.localizedDescription
                    //print(error.localizedDescription)
                }
            } receiveValue: { [weak self] value in
                //            do {
                //                let repo = try JSONDecoder().decode(Repository.self, from: value.data)
                //                print(repo)
                //            }
                //            catch {
                //                print(error.localizedDescription)
                //            }
                print(value)
                self?.nameLabel.text = value.url.description
            }

    }
}
