// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct LoginModel: Codable {
    let success: Bool?
    let user_id: Int?
    let full_name: String?
    let token: String?
    let avatar_url: String?
    let username: String?
    let mobile: String?
    let rabbit_info: RabbitInfoModel?
    let default_map_style: String?
    let default_lat: Double?
    let default_lon: Double?
    let host_video_call: String?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case user_id = "user_id"
        case full_name = "full_name"
        case token = "token"
        case avatar_url = "avatar_url"
        case username = "username"
        case mobile = "mobile"
        case rabbit_info = "rabbit_info"
        case default_map_style = "default_map_style"
        case default_lat = "default_lat"
        case default_lon = "default_lon"
        case host_video_call = "host_video_call"
    }
}

struct RabbitInfoModel: Codable {
    var rABBIT_USER: String?
    var rABBIT_PASS: String?
    var rABBIT_HOST: String?
    var rABBIT_PORT: Int?
    var rABBIT_VHOT: String?
    var cHATTING_QUEUE: String?
    var cHATTING_EXCHANGE_TOPIC: String?
    var cHATTING_EXCHANGE_DIRECT: String?

    enum CodingKeys: String, CodingKey {
        case rABBIT_USER = "RABBIT_USER"
        case rABBIT_PASS = "RABBIT_PASS"
        case rABBIT_HOST = "RABBIT_HOST"
        case rABBIT_PORT = "RABBIT_PORT"
        case rABBIT_VHOT = "RABBIT_VHOT"
        case cHATTING_QUEUE = "CHATTING_QUEUE"
        case cHATTING_EXCHANGE_TOPIC = "CHATTING_EXCHANGE_TOPIC"
        case cHATTING_EXCHANGE_DIRECT = "CHATTING_EXCHANGE_DIRECT"
    }
}
