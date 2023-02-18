//
//  ServiceTableViewCell.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import UIKit

final class ServiceTableViewCell: UITableViewCell {
    
    static let identifier = "ServiceTableViewCell"
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [serviceImage, serviceTitle])
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 8
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
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(contentStackView)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with title: String, imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        serviceTitle.text = title
        serviceImage.loadImage(by: url)
    }
    
}

extension ServiceTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            serviceImage.heightAnchor.constraint(equalToConstant: 60),
            serviceImage.widthAnchor.constraint(equalToConstant: 60),
            
        ])
    }
    
}
