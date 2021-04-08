// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import RxSwift
import Foundation

protocol ProjectSaleLibraryViewModelProtocol {
    var didChange: PassthroughSubject<ProjectSaleLibraryViewModel, Never> { get }
    var disposable: Set<AnyCancellable> { get }
    func fetchDataLibrary(project_id: Int)
}

class ProjectSaleLibraryViewModel: ObservableObject, ProjectSaleLibraryViewModelProtocol {
    var disposable: Set<AnyCancellable> = Set<AnyCancellable>()
    @Published var LibraryData: ProjectSaleLibraryModel?
    var didChange: PassthroughSubject<ProjectSaleLibraryViewModel, Never> = PassthroughSubject<ProjectSaleLibraryViewModel, Never>()
    var isHasData: AnyPublisher<Bool, Never> {
        return $LibraryData
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
    func fetchDataLibrary(project_id: Int) {
        let param: [String: Any] = ["project_sale_id": project_id]

        ProjectSaleLibraryService.ProjectSaleLibraryService(url: Project.Sale_Library, param: param, method: .POST, header: Networking.shared.getHeader())
            .map { ($0) }
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
                self.LibraryData = value
            }.store(in: &disposable)
    }
}
