// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol ProjectServicesProtocol {
    static func projectService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectListResponeModel, ErrorStatus>
}

class projectService: ProjectServicesProtocol {
    static func projectService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectListResponeModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }
}
