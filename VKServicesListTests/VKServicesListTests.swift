//
//  VKServicesListTests.swift
//  VKServicesListTests
//
//  Created by Павел Кай on 18.02.2023.
//

import XCTest
@testable import VKServicesList

final class VKServicesListTests: XCTestCase {
    
    let manager = APIManager()
    
    enum LinksTest: String {
        case vk = "https://vk.com/"
        case mail = "https://cloud.mail.ru/"
    }
    
    enum APIUrls: APIUrlsProtocol {
        case goodCase
        case badCase
        
        var url: URL? {
            switch self {
            case .goodCase:
                return URL(string: "https://mobile-olympiad-trajectory.hb.bizmrg.com/semi-final-data.json")
            case .badCase:
                return URL(string: "someUrl")
            }
        }
        
        
    }
    
    func testAPI() async {
        var apiResult: Any?
        
        do {
            let result = try await manager.getContent(by: APIUrls.goodCase, type: ServiceResponse.self)
            apiResult = result
        } catch {
            print(error)
        }
        
        XCTAssertNotNil(apiResult)
    }
    
    func testAPIWithBadURL() async {
        var apiResult: Any?
        
        do {
            let result = try await manager.getContent(by: APIUrls.badCase, type: ServiceResponse.self)
            apiResult = result
        } catch {
            print(error)
        }
        
        XCTAssertNil(apiResult)
    }
    
    func testWebViewWithMailLink() {
        let vc = VKServiceDetailViewController()
        let webView = vc.createWebView(by: LinksTest.mail.rawValue)
        XCTAssertNotNil(webView)
    }
    
    func testWebViewWithVKLink() {
        let vc = VKServiceDetailViewController()
        let webView = vc.createWebView(by: LinksTest.vk.rawValue)
        XCTAssertNotNil(webView)
    }
    
    func testWebViewWithBabLink() {
        let vc = VKServiceDetailViewController()
        let webView = vc.createWebView(by: "")
        XCTAssertNil(webView)
    }
    
}
