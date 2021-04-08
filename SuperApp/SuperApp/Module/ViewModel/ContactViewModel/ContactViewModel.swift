// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine
import RxSwift

protocol ContactViewModelProtocol {
    var didChange: PassthroughSubject<ContactViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }
    func fetchDataContact()
}

class ContactViewModel: ObservableObject, ContactViewModelProtocol {
    var disposables = Set<AnyCancellable>()

    @Published var contactDeveloperModel: ContactDeveloperModel?
    @Published var contactTradingModel: [ContactTradingModel]?

    public var didChange = PassthroughSubject<ContactViewModel, Never>()

    var vldContactDeveloperModel: AnyPublisher<Bool, Never> {
        return $contactDeveloperModel
            .delay(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }
    var vldContactTradingModel: AnyPublisher<Bool, Never> {
        return $contactTradingModel
            .delay(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    func fetchDataContact() {
        ContactService.contactService(url: ContactUrl.contact, param: [:], method: .GET, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0) }
        // remove duplicates in array
        .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error ContactViewModel_fetchDataContact")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.contactDeveloperModel = value.developer_project ??
                    ContactDeveloperModel(logo_url: "", project_address: "", hotline: "", fax: "")
                    self.contactTradingModel = value.trading ?? []
                }).store(in: &disposables)
    }
}
