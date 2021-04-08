// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol HomeServiceProtocol {
    static func homeDiscoverService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeDiscoverModel, ErrorStatus>
    static func homeProjectListService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeProjectModel, ErrorStatus>
    static func homeProductSelling(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeProductSellingModel, ErrorStatus>
}

class HomeService: HomeServiceProtocol {
    static func homeDiscoverService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeDiscoverModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }

    static func homeProjectListService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeProjectModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }

    static func homeProductSelling(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<HomeProductSellingModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
