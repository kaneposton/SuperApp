// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol UtilitiesViewModelProtocol {
    var didChange: PassthroughSubject<UtilitiesViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }
    func fetchDataUtilities(language: Int, projectId: Int)
}

class UtilitiesViewModel: ObservableObject, UtilitiesViewModelProtocol {
    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()

    @Published var utilitiesListArea: [UtilitiesListAreaModel]?
    @Published var utilitiesListUtilities: [UtilitiesListUtilitiesModel]?

    public var didChange = PassthroughSubject<UtilitiesViewModel, Never>()

    var vldUtilitiesListArea: AnyPublisher<Bool, Never> {
        return $utilitiesListArea
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

    var vldUtilitiesListUtilities: AnyPublisher<Bool, Never> {
        return $utilitiesListUtilities
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

    func fetchDataUtilities(language: Int, projectId: Int) {
        var param: [String: Any] = [:]
        if language > 0 && projectId > 0 {
            param["language"] = language
            param["project_id"] = projectId
        }

        UlitiesService.ulitiesService(url: UlitiesUrl.ulities, param: param, method: .POST, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0) }
        // remove duplicates in array
        .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.utilitiesListUtilities = value.list_utilities ?? []
                    self.utilitiesListArea = value.list_area ?? []
                }).store(in: &disposables)
    }
}
