//
//  ServiceItem.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import Foundation

struct ServiceResponse: Decodable {
    let items: [ServiceItem]
}

struct ServiceItem: Decodable {
    let name: String
    let description: String
    let icon_url: String
    let service_url: String
}
