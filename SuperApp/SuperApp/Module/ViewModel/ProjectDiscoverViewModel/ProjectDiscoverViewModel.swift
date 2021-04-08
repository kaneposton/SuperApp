// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import Foundation
import RxSwift

class ProjectDiscoverViewModel: ObservableObject {
    public let didChange = PassthroughSubject<ProjectDiscoverViewModel, Never>()
    @Published var data: [DiscoverProvinceModel] = [] {
        didSet {
            didChange.send(self)
        }
    }

    private var disposables = Set<AnyCancellable>()

    func fetchData () {
        let param: [String: Any] = [:]
        ProjectDiscoverService.ProjectDiscoverService(url: Project.discover, param: param, method: .GET, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.list!) }
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
                    self.data = value
                }).store(in: &disposables)
    }
}
