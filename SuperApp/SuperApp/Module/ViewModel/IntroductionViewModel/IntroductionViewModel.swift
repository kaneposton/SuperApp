// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine

protocol IntroductionViewModelProtocol {
    var didChange: PassthroughSubject<IntroductionViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }
    func fetchDataIntroduction(projectId: Int)
}

class IntroductionViewModel: ObservableObject, IntroductionViewModelProtocol {
    var disposables: Set<AnyCancellable> = Set<AnyCancellable>()

    @Published var introductionList: IntroductionListModel?

    public var didChange = PassthroughSubject<IntroductionViewModel, Never>()

    var vldIntroductionList: AnyPublisher<Bool, Never> {
        return $introductionList
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

    func fetchDataIntroduction(projectId: Int = 0) {
        var param: [String: Any] = [:]
        if projectId > 0 {
            param["project_id"] = projectId
        }

        IntroductionService.introductionService(url: Project.introduction, param: param, method: .POST, header: Networking.shared.getHeader())
        // filter array data from server
        .map { ($0.info ?? IntroductionListModel()) }
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
                    self.introductionList = value
                }).store(in: &disposables)
    }
}
