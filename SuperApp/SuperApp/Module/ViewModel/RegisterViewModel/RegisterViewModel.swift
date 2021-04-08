// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Combine
import Foundation
import RxSwift

protocol RegisterViewModelProtocol {
    var didChange: PassthroughSubject<RegisterViewModel, Never> { get }
    var disposable: Set<AnyCancellable> { get }
    func registerViewModel(email: String, username: String, password: String)
}

class RegisterViewModel: ObservableObject, RegisterViewModelProtocol {
    public let didChange = PassthroughSubject<RegisterViewModel, Never>()
    @Published var registerModel: RegisterModel?
    var disposable: Set<AnyCancellable> = []

    init () { }

    var registerResult: AnyPublisher<Bool, Never> {
        return $registerModel
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    func registerViewModel(email: String, username: String, password: String) {
        let params: [String: Any] = ["email": email, "username": username, "password": password, "mobile": "0901018940"]
        RegisterService.RegisterService(url: RegisterURL.RegisUrl, param: params, method: .POST, header: Networking.shared.getHeader())
            .map { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.registerModel = value
                }).store(in: &disposable)
    }
}
