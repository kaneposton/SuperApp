// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine
import MBProgressHUD

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ErrorStatus> {
    let decode = JSONDecoder()

    return Just(data)
        .decode(type: T.self, decoder: decode)
        .mapError { error in
                .parsing(description: error.localizedDescription)
        }.eraseToAnyPublisher()
}
