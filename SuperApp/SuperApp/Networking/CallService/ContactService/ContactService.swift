// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol ContactServiceProtocol {
    static func contactService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ContactModel, ErrorStatus>
}

class ContactService: ContactServiceProtocol {
    static func contactService(url: String, param: [String: Any]?, method: METHOD, header: [String: Any]?) -> AnyPublisher<ContactModel, ErrorStatus> {
        Networking.shared.fetchData(isShowHUB: true, url: url, params: param!, method: method, header: header!, isLogin: false)
    }
}
