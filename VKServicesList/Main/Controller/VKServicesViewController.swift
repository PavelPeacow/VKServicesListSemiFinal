//
//  ViewController.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import UIKit

final class VKServicesViewController: UIViewController {
    
    var serviceItems = [ServiceItem]()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        setUpNavBar()
        performAsyncTasks()
        setDelegates()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    private func setUpNavBar() {
        title = "Проекты VK"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func performAsyncTasks() {
        Task {
            await getVKServiceItems()
            tableView.reloadData()
        }
    }

}

extension VKServicesViewController {
    
    @objc func getVKServiceItems() async {
        do {
            let result = try await APIManager().getContent(by: .serviceList, type: ServiceResponse.self)
            serviceItems = result.items
            print(serviceItems)
        } catch {
            print(error)
            createAlert(with: error.localizedDescription)
            createBackgroundErrorView(with: error.localizedDescription)
        }
    }
    
    func createAlert(with title: String) {
        let ac = UIAlertController(title: title, message: "Попробуйте ещё раз!", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK!", style: .default))
        present(ac, animated: true)
    }
    
    func createBackgroundErrorView(with text: String) {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .systemGray
        label.textAlignment = .center
        label.text = text
        
        tableView.backgroundView = label
        tableView.isScrollEnabled = false
    }
    
}

extension VKServicesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        serviceItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.identifier, for: indexPath) as? ServiceTableViewCell else {
            return UITableViewCell()
        }
        
        let service = serviceItems[indexPath.row]
        
        cell.configure(with: service.name, imageURL: service.icon_url)
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}

extension VKServicesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let serviceItem = serviceItems[indexPath.row]
        
        let vc = VKServiceDetailViewController()
        vc.configure(serviceItem: serviceItem)
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
