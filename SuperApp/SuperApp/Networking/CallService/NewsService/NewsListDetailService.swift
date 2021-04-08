//
//  NewsListDetailService.swift
//  SuperApp
//
//  Created by hoanglinh on 4/21/20.
//  Copyright © 2020 Tran Thien Phu. All rights reserved.
//

import SwiftUI
import Combine
import RxSwift
protocol NewsListDetailServiceProtocol{
     static func NewsListDetailService(url : String, param : [String: Any]?,method: METHOD, header: [String: Any]?) -> AnyPublisher<NewsDetailModel,ErrorStatus>
}
class NewsListDetailService: NewsListDetailServiceProtocol {
    static func NewsListDetailService(url: String, param: [String : Any]?, method: METHOD, header: [String : Any]?) -> AnyPublisher<NewsDetailModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }

}
