//
//  VKServiceDetailViewController.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import UIKit
import SafariServices

final class VKServiceDetailViewController: UIViewController {
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [serviceImage, serviceTitle, serviceDescription, serviceLink])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var serviceImage: UIImageViewURL = {
        let image = UIImageViewURL()
        image.contentMode = .scaleToFill
        return image
    }()
    
    private lazy var serviceTitle: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var serviceDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var serviceLink: UILabel = {
        let label = UILabel()
        label.isUserInteractionEnabled = true
        label.textColor = .systemBlue
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(contentStackView)
        view.backgroundColor = .systemBackground
        
        addGesture()
        setConstraints()
    }
    
    private func addGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapServiceLink(_:)))
        serviceLink.addGestureRecognizer(gesture)
    }
    
    func configure(serviceItem: ServiceItem) {
        guard let url = URL(string: serviceItem.icon_url) else { return }
        serviceImage.loadImage(by: url)
        serviceTitle.text = serviceItem.name
        serviceDescription.text = serviceItem.description
        serviceLink.text = serviceItem.service_url
    }

}

extension VKServiceDetailViewController {
    
    @objc func didTapServiceLink(_ sender: UITapGestureRecognizer) {
        guard let url = (sender.view as? UILabel)?.text else { return }
        showWebView(by: url)
    }
    
    func showWebView(by link: String) {
        guard let url = URL(string: link) else { return }

        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}

extension VKServiceDetailViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        ])
    }
    
}
