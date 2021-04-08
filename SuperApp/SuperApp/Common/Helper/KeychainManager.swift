// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import KeychainSwift

enum KeychainItem: String {
    case deviceToken = "deviceToken"
    case token = "Token"
    case user_id = "user_id"
    case employee_id = "employee_id"
    case avatar_url = "avatar_url"
    case KEY_MAP = "KEY_MAP"
    case BACKGROUND_URL = "BACKGROUND_URL"
    case username = "username"
    case password = "password"
    case mobile = "mobile"
    case language_id = "language_id"
    case language = "language"
    case province_id = "province_id"
    case region_list = "region_list"
    case project_id = "project_id"
    case task_id = "task_id"
    case model = "model"
    case group_id = "group_id"
    case document_name = "document_name"
    case modelAllStatuss = "modelAllStatuss"
    case RABBIT_USER = "RABBIT_USER"
    case RABBIT_PASS = "RABBIT_PASS"
    case RABBIT_HOST = "RABBIT_HOST"
    case RABBIT_PORT = "RABBIT_PORT"
    case RABBIT_VHOT = "RABBIT_VHOT"
    case CHATTING_QUEUE = "CHATTING_QUEUE"
    case CHATTING_EXCHANGE = "CHATTING_EXCHANGE"
    case default_lat = "default_lat"
    case default_lon = "default_lon"
    case default_map_style = "default_map_style"
    case savelogin = "savelogin"
}

class KeychainManager {
    static let shared: KeychainManager = {
        let instance = KeychainManager()

        return instance
    }()
    let keychain = KeychainSwift()
    func setToken(_ token: String) {
        keychain.set(token, forKey: KeychainItem.token.rawValue)
    }
    func getToken() -> String? {
        return keychain.get(KeychainItem.token.rawValue)
    }
    func deleteAllSavedData() {
        keychain.clear()
    }
    func deleteToken() {
        keychain.delete(KeychainItem.token.rawValue)
    }
    func saveString(value: String, forkey key: KeychainItem) {
        keychain.set(value, forKey: key.rawValue)
    }
    func deleteString(forkey key: KeychainItem) {
        keychain.delete(key.rawValue)
    }
    func getString(key: KeychainItem) -> String? {
        return keychain.get(key.rawValue)
    }
    func setLanguage(value: String, forkey key: KeychainItem) {
        keychain.set(value, forKey: key.rawValue)
    }
    func getLanguage(key: KeychainItem) -> String? {
        return keychain.get(key.rawValue)
    }
}
