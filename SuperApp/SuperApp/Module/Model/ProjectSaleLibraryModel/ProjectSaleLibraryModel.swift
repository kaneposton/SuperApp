// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ProjectSaleLibraryModel: Codable, Hashable {
    var success: Bool?
    var list_image: [List_image]?
    var list_video: [List_video]?
    var list_ar: [List_AR]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list_image = "list_image"
        case list_video = "list_video"
        case list_ar = "list_ar"
    }
}
//MARK: Get list image model
struct List_image: Codable, Hashable {
    var index = 0
    var url: String?
    var info: Info?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

//MARK: Get list video model
struct List_video: Codable, Hashable {
    var index = 0
    var url: String?
    var info: Info?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

//MARK: Get list ar model
struct List_AR: Codable, Hashable {
    var index = 0
    var url: String?
    var info: Info?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

//MARK: Get info  model
struct Info: Codable, Hashable {
    var description: String?
    enum CodingKeys: String, CodingKey {
        case description = "description"
    }
}
