//
//  NewListService.swift
//  SuperApp
//
//  Created by hoanglinh on 4/21/20.
//  Copyright © 2020 Tran Thien Phu. All rights reserved.
//

import SwiftUI
import Combine

protocol NewListServiceProtocol {
    static func NewsListService(url : String, param : [String: Any]?,method: METHOD, header: [String: Any]?) -> AnyPublisher<ListNewsModel,ErrorStatus>
}
class NewsListService: NewListServiceProtocol {
    static func NewsListService(url: String, param: [String : Any]?, method: METHOD, header: [String : Any]?) -> AnyPublisher<ListNewsModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }


}


