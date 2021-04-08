// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine
import RxSwift

protocol LoginViewModelProtocol {
    var didChange: PassthroughSubject<LoginViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }
    func fetchDataLogin(userName: String, passWord: String)
}

class LoginViewModel: ObservableObject, LoginViewModelProtocol {
    var disposables = Set<AnyCancellable>()

    @Published var userProfile: LoginModel?

    public var didChange = PassthroughSubject<LoginViewModel, Never>()

    var vldLogin: AnyPublisher<Bool, Never> {
        return $userProfile
            .delay(for: 0.5, scheduler: RunLoop.main)
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    func fetchDataLogin(userName: String, passWord: String) {
        // KeychainManager.shared.deleteAllSavedData()
//        let deviceToken = KeychainManager.shared.getString(key: .deviceToken)
//        let param: [String : Any] = ["device_token" : deviceToken ?? ""]

        LoginService.loginService(url: LoginUrl.LoginUrl, param: [:], method: .POST, header: ["Authorization": Networking.shared.aut_basic(userName, password: passWord)!, "MNV-Device": Networking.shared.genOTP()!])
            .map { ($0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.userProfile = value
                    if value.success ?? false {
                        // lưu data xuống keychain
                        KeychainManager.shared.saveString(value: "\(String(describing: self.userProfile?.user_id == 0 ? 0 : self.userProfile?.user_id ?? 0))", forkey: .user_id)
                        KeychainManager.shared.saveString(value: self.userProfile?.token == nil ? "" : self.userProfile?.token ?? "", forkey: .token)

                        // info map
                        KeychainManager.shared.saveString(value: "\(String(describing: value.default_lat ?? 0))", forkey: .default_lat)
                        KeychainManager.shared.saveString(value: "\(String(describing: value.default_lon ?? 0))", forkey: .default_lon)
                        KeychainManager.shared.saveString(value: value.default_map_style ?? "", forkey: .default_map_style)

                        // save userpass
                        KeychainManager.shared.saveString(value: "\(String(describing: userName))", forkey: .username)
                        KeychainManager.shared.saveString(value: "\(String(describing: passWord))", forkey: .password)
                    }
                    // save userpass test
                    KeychainManager.shared.saveString(value: "\(String(describing: userName))", forkey: .username)
                    KeychainManager.shared.saveString(value: "\(String(describing: passWord))", forkey: .password)
                }
            ).store(in: &disposables)
    }
}
