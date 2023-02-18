//
//  APIManager.swift
//  VKServicesList
//
//  Created by Павел Кай on 18.02.2023.
//

import Foundation

protocol APIUrlsProtocol {
    var url: URL? { get }
}

enum APIError: LocalizedError {
    case badURL
    case canNotGet
    case canNotDecode
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "Неправильный URL адресс!"
        case .canNotGet:
            return "Не удалось получить данные!"
        case .canNotDecode:
            return "Не удалось декодировать полученные данные!"
        }
    }
}

enum APIUrls: APIUrlsProtocol {
    case serviceList
    
    var url: URL? {
        switch self {
        case .serviceList:
            return URL(string: "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json")
        }
    }
}

final class APIManager {
    
    private let urlSession: URLSession
    private let jsonDecoder: JSONDecoder
    
    init(urlSession: URLSession = .shared, jsonDecoder: JSONDecoder = .init()) {
        self.urlSession = urlSession
        self.jsonDecoder = jsonDecoder
    }
    
    func getContent<T: Decodable>(by url: APIUrlsProtocol, type: T.Type) async throws -> T {
        guard let url = url.url else { throw APIError.badURL }
        
        let request = URLRequest(url: url)
        
        guard let (data, _) = try? await urlSession.data(for: request) else { throw APIError.canNotGet }
        
        guard let result = try? jsonDecoder.decode(T.self, from: data) else { throw APIError.canNotDecode }
        
        return result
    }
    
}
