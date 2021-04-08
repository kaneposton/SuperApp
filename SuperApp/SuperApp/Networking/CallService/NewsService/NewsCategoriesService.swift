

import SwiftUI
import Combine

protocol CategoriesServiceProtocol {
    static func NewsCategoriesService(url : String, param : [String: Any]?,method: METHOD, header: [String: Any]?) -> AnyPublisher<CategoritesModel,ErrorStatus>
}
class NewsCategoriesService: CategoriesServiceProtocol {
    static func NewsCategoriesService(url: String, param: [String : Any]?, method: METHOD, header: [String : Any]?) -> AnyPublisher<CategoritesModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
