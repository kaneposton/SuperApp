// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import RxSwift
import Combine
import Foundation

protocol ProjectSalesViewModelProtocol {
    var didChange: PassthroughSubject<ProjectSalesViewModel, Never> { get }
    var disposable: Set<AnyCancellable> { get }
    func fetchDataProjectSales(project_id: Int)
}

class ProjectSalesViewModel: ObservableObject, ProjectSalesViewModelProtocol {
    var didChange: PassthroughSubject<ProjectSalesViewModel, Never> = PassthroughSubject<ProjectSalesViewModel, Never>()
    var disposable: Set<AnyCancellable> = Set<AnyCancellable>()
    @Published var projectSales: [SalesModel]?

    var isHasData: AnyPublisher<Bool, Never> {
        return $projectSales
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

    func fetchDataProjectSales(project_id: Int) {
        let param: [String: Any] = ["project_id": project_id]
        ProjectSalesService.ProjectSalesService(url: Project.Sales, param: param, method: .POST, header: Networking.shared.getHeader())
            .map { ($0.list) }
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case.failure: print("error")
                case.finished: return
                }
            }) { [weak self] value in
                guard let self = self else { return }
                self.projectSales = value
            }.store(in: &disposable)
    }
}
