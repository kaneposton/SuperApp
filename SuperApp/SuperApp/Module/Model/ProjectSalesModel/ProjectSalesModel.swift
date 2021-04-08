// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation
import Combine

struct ProjectSalesModel: Codable, Hashable {
    let success: Bool?
    let list: [SalesModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list = "list"
    }
}
struct SalesModel: Codable, Hashable {
    let url: String?
    let id_url: Int?
    let info: Info?
    let url_brochure: String?
    let id_url_brochure: Int?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case id_url = "id_url"
        case info = "info"
        case url_brochure = "url_brochure"
        case id_url_brochure = "id_url_brochure"
    }
}
