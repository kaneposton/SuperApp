// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

protocol NewsServiceProtocol {
    static func NewsCategoriesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<NewsCatesModel, ErrorStatus>
    static func NewsListService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ListNewsModel, ErrorStatus>
    static func NewsListDetailService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<NewsDetailModel, ErrorStatus>
}

class NewsService: NewsServiceProtocol {
    static func NewsCategoriesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<NewsCatesModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
    static func NewsListService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ListNewsModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
    static func NewsListDetailService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<NewsDetailModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
