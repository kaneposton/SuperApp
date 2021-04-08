// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import Foundation
import RxSwift

protocol FilterViewModelProtocol {
    var didChange: PassthroughSubject<FilterViewModel, Never> { get }
    var disposable: Set<AnyCancellable> { get }
    func fetchDataFilterStatus(language: Int)
    func fetchDataFilterProject(language: Int)
    func fetchDataFilterCity()
    func fetchDataFilterDistrict(province_id: Int)
}

class FilterViewModel: ObservableObject, FilterViewModelProtocol {
    var disposable: Set<AnyCancellable> = Set<AnyCancellable> ()

    @Published var filterStatusList: [FilterStatusListModel]?
    @Published var filterProjectList: [FilterProjectListModel]?
    @Published var filterCityList: [FilterCityListModel]?
    @Published var filterDistrictList: [FilterDistrictListModel]?

    public let didChange = PassthroughSubject<FilterViewModel, Never>()

    var vldFilterStatusList: AnyPublisher<Bool, Never> {
        return $filterStatusList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldFilterProjectList: AnyPublisher<Bool, Never> {
        return $filterProjectList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldFilterCityList: AnyPublisher<Bool, Never> {
        return $filterCityList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldFilterDistrictList: AnyPublisher<Bool, Never> {
        return $filterDistrictList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(true)) }
                    else { promise(.success(false)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    func fetchDataFilterStatus(language: Int = VIETNAM) {
        FilterService.filterStatusService(url: FilterUrl.filterStatus + "\(language)", param: [:], method: .GET, header: Networking.shared.getHeader())
            .map { ($0.list ?? []) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.filterStatusList = value
                }).store(in: &disposable)
    }

    func fetchDataFilterProject(language: Int = VIETNAM) {
        FilterService.filterProjectService(url: FilterUrl.filterProject + "\(language)", param: [:], method: .GET, header: Networking.shared.getHeader())
            .map { ($0.list ?? []) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.filterProjectList = value
                }).store(in: &disposable)
    }

    func fetchDataFilterCity() {
        FilterService.filterCityService(url: FilterUrl.filterCity, param: [:], method: .GET, header: Networking.shared.getHeader())
            .map { ($0.data ?? []) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.filterCityList = value
                }).store(in: &disposable)
    }

    func fetchDataFilterDistrict(province_id: Int = -1) {
        let param: [String: Any] = province_id != -1 ? ["province_id": province_id] : ["province_id": 0]

        FilterService.filterDistrictService(url: FilterUrl.filterDistrict, param: param, method: .POST, header: Networking.shared.getHeader())
            .map { ($0.data ?? []) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure: print("Error")
                case .finished: return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }
                    self.filterDistrictList = value
                }).store(in: &disposable)
    }
}
