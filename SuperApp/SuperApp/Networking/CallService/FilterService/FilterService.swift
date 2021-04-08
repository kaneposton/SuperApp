// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol FilterServiceProtocol {
    static func filterStatusService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterStatusModel, ErrorStatus>
    static func filterProjectService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterProjectModel, ErrorStatus>
    static func filterCityService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterCityModel, ErrorStatus>
    static func filterDistrictService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterDistrictModel, ErrorStatus>
}

class FilterService: FilterServiceProtocol {
    static func filterStatusService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterStatusModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }

    static func filterProjectService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterProjectModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }

    static func filterCityService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterCityModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }

    static func filterDistrictService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<FilterDistrictModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
