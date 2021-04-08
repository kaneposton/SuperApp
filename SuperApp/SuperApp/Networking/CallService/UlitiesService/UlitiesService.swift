// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol UlitiesServiceProtocol {
    static func ulitiesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<UtilitiesModel, ErrorStatus>
}
class UlitiesService: UlitiesServiceProtocol {
    static func ulitiesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<UtilitiesModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }
}
