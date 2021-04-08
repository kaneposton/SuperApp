// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import Foundation

protocol HomeViewModelProtocol {
    var didChange: PassthroughSubject<HomeViewModel, Never> { get }
    var vldListDiscover: AnyPublisher<[HomeDiscoverListModel]?, Never> { get }
    var vldProjectList: AnyPublisher<[HomeProjectListModel]?, Never> { get }
    var vldProductSellingList: AnyPublisher<[HomeProductSellListModel]?, Never> { get }

    func fetchDataDiscover()
    func fetchDataProjectList(settingType: [Int], provinceId: [Int], projectStatus: [Int], language: Int, districtId: [Int])
    func fetchDataProductSelling(language: Int)
}

class HomeViewModel: ObservableObject, HomeViewModelProtocol {
    public let didChange = PassthroughSubject<HomeViewModel, Never>()

    @Published var homeDiscoverList: [HomeDiscoverListModel]?
    @Published var homeProjectList: [HomeProjectListModel]?
    @Published var homeProductSellingList: [HomeProductSellListModel]?
    @Published var filterProjectList: [HomeProjectListModel]?

    @Published var isHasData: Bool? = false {
        willSet {
            didChange.send(self)
        }
    }

    private var disposables = Set<AnyCancellable>()

    var vldListDiscover: AnyPublisher<[HomeDiscoverListModel]?, Never> {
        return $homeDiscoverList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(list)) }
                    else { promise(.success(nil)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldProjectList: AnyPublisher<[HomeProjectListModel]?, Never> {
        return $homeProjectList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(list)) }
                    else { promise(.success(nil)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldProductSellingList: AnyPublisher<[HomeProductSellListModel]?, Never> {
        return $homeProductSellingList
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil { promise(.success(list)) }
                    else { promise(.success(nil)) }
                }
            }.switchToLatest()
            .eraseToAnyPublisher()
    }

    var vldShowData: AnyPublisher<([HomeDiscoverListModel]?, [HomeProjectListModel]?, [HomeProductSellListModel]?), Never> {
        return Publishers.CombineLatest3(vldListDiscover, vldProjectList, vldProductSellingList)
            .receive(on: RunLoop.main)
            .map { vldDis, vldProList, vldProSell in
                guard let _vldDis = vldDis, let _vldProList = vldProList, let _vldProSell = vldProSell else { return (nil, nil, nil) }
                self.isHasData = true
                return (_vldDis, _vldProList, _vldProSell)
            }.eraseToAnyPublisher()
    }

    var vldListDiscoverBool: AnyPublisher<Bool, Never> {
        return $homeDiscoverList
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
        return $homeProjectList
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

    func fetchDataDiscover() {
        HomeService.homeDiscoverService(url: HomeUrl.homeDiscover, param: [:], method: .GET, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.list ?? []) }
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
                    self.homeDiscoverList = value
                }).store(in: &disposables)
    }

    func fetchDataProjectList(settingType: [Int], provinceId: [Int], projectStatus: [Int], language: Int, districtId: [Int]) {
        var param: [String: Any] = [:]

        if settingType.count > 0 && settingType != [0] { param["project_setting_type"] = settingType }
        if provinceId.count > 0 { param["province_id"] = provinceId }
        if projectStatus == [0] { param["is_selling"] = true }
        if projectStatus == [1] { param["is_selling"] = false }
        if language >= 0 { param["language"] = language }
        if districtId.count > 0 { param["district_id"] = districtId }

        print("param", param)
        HomeService.homeProjectListService(url: HomeUrl.homeProjectList, param: param, method: .POST, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.list ?? []) }
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
                    self.homeProjectList = value
                }).store(in: &disposables)
    }

    func fetchDataProductSelling(language: Int = VIETNAM) {
        let param: [String: Any] = ["language": language]
        HomeService.homeProductSelling(url: HomeUrl.homeProductSelling, param: param, method: .POST, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.list ?? []) }
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
                    self.homeProductSellingList = value
                }).store(in: &disposables)
    }
}
