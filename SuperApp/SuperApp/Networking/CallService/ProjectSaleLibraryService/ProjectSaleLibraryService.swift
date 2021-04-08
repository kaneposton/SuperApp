// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

protocol ProjectSaleLibraryServiceProtocol {
    static func ProjectSaleLibraryService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectSaleLibraryModel, ErrorStatus>
}

class ProjectSaleLibraryService: ProjectSaleLibraryServiceProtocol {
    static func ProjectSaleLibraryService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectSaleLibraryModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
