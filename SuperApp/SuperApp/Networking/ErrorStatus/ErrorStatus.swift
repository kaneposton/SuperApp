// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

enum ErrorStatus: Error, LocalizedError {
    case unknow, apiError(description: String), network(description: String), parsing(description: String)

    var errorDescription: String? {
        switch self {
        case .apiError(let descriptionError): return descriptionError
        case .network(let descriptionErrorNetwork): return descriptionErrorNetwork
        case .parsing(let descriptionErrorParsing): return descriptionErrorParsing
        default: return "Unown error"
        }
    }
}
