//
//  ViewController.swift
//  Intro-to-combine
//
//  Created by ShafiulAlam-00058 on 4/11/23.
//

import UIKit
import Combine

class CustomTVC: UITableViewCell {
    
}

class ViewController: UIViewController, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(CustomTVC.self, forCellReuseIdentifier: "cell")
        return table
    }()

    var model = [String]()
    var observer: AnyCancellable?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.frame = view.bounds
        tableView.backgroundColor = .gray
        
        observer = NetworkManager.shared.fetchData()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finished!")
            case .failure(let error):
                print(error)
            }
        }, receiveValue: { [weak self] value in
            self?.model = value
            self?.tableView.reloadData()
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTVC else {
            fatalError()
        }
        
        cell.textLabel?.text = model[indexPath.row]
        
        return cell
    }

}

