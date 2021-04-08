// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol LocationViewModelProtocol {
    var didChange: PassthroughSubject<LocationViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }

    func fetchDataLocation(projectId: Int)
}

class LocationViewModel: ObservableObject, LocationViewModelProtocol {
    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()

    @Published var locationList: [LocationListModel]?

    public var didChange = PassthroughSubject<LocationViewModel, Never>()

    var vldLlocationList: AnyPublisher<Bool, Never> {
        return $locationList
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

    func fetchDataLocation(projectId: Int) {
        var param: [String: Any] = [:]
        if projectId > 0 {
            param["project_id"] = projectId
        }
        LocationService.locationService(url: SaleUrl.location, param: param, method: .POST, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.list ?? []) }
        // remove duplicates in array
        .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error LocationViewModel_fetchDataLocation")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.locationList = value
                }).store(in: &disposables)
    }
}
