// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import Foundation
import RxSwift

protocol ProjectSalesServiceProtocol {
    static func ProjectSalesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectSalesModel, ErrorStatus>
}

struct ProjectSalesService: ProjectSalesServiceProtocol {
    static func ProjectSalesService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ProjectSalesModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!)
    }
}
