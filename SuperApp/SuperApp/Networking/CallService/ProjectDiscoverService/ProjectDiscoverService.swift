// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

protocol ProjectDiscoverServiceProtocol {
    static func ProjectDiscoverService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectDiscoverModel, ErrorStatus>
}

class ProjectDiscoverService: ProjectDiscoverServiceProtocol {
    static func ProjectDiscoverService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectDiscoverModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
