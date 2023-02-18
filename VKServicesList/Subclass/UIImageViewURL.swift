//
//  UIImageViewURL.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import UIKit

final class UIImageViewURL: UIImageView {
    
    var task: URLSessionDataTask?
    let loadingView = UIActivityIndicatorView(style: .medium)
    
    func loadImage(by url: URL) {
        image = nil
        
        if let task = task {
            task.cancel()
        }
        
        task = URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, _, error in
            guard let data = data, error == nil else { return }
            
            guard let image = UIImage(data: data) else { return}
            
            DispatchQueue.main.async {
                self?.image = image
                self?.removeLoadingView()
            }
        })
        task?.resume()
        
    }
    
    private func setLoadingView() {
        addSubview(loadingView)
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        
        loadingView.startAnimating()
        
        NSLayoutConstraint.activate([
            loadingView.centerXAnchor.constraint(equalTo: centerXAnchor),
            loadingView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    private func removeLoadingView() {
        loadingView.removeFromSuperview()
    }
    
}
