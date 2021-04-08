// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine
import RxSwift

class ProjectListViewModel: ObservableObject {
    public let didChange = PassthroughSubject<ProjectListViewModel, Never>()
    @Published var data: [ProjectListModel] = [] {
        didSet {
            didChange.send(self)
        }
    }
    private var disposables = Set<AnyCancellable>()
    var signalPush: PublishSubject<Bool> = PublishSubject<Bool>()

    func fetchData () {
        let param: [String: Any] = ["project_name": ""]
        projectService.projectService(url: Project.projectList, param: param, method: .POST, header: Networking.shared.getHeader())
            .map {
                ($0).list ?? []
            }.receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case .failure:
                    print("Error")
                    self?.signalPush.onNext(false)
                case .finished:                    return
                }
            }, receiveValue: { [weak self] value in
                    guard let self = self else { return }

                    self.data = value
                    let parseDictionary = Utils.convertToDictionary(str: self.data[0].location ?? "")
                    print("result \(String(describing: parseDictionary))")
                    self.signalPush.onNext(true)
                }).store(in: &disposables)
    }
}
