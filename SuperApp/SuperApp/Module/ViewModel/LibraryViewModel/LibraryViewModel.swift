// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import Combine
import RxSwift

protocol LibraryViewModelProtocol {
    var didChange: PassthroughSubject<LibraryViewModel, Never> { get }
    var disposables: Set<AnyCancellable> { get }
    func fetchDataLibrary(project_id: Int)
}

class LibraryViewModel: ObservableObject, LibraryViewModelProtocol {
    var disposables = Set<AnyCancellable>()

    @Published var libraryListImage: [LibraryListImageModel]?
    @Published var libraryListVideo: [LibraryListVideoModel]?
    @Published var libraryListAR: [LibraryListARModel]?

    public var didChange = PassthroughSubject<LibraryViewModel, Never>()

    var vldLibraryListImage: AnyPublisher<Bool, Never> {
        return $libraryListImage
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
    var vldLibraryListVideo: AnyPublisher<Bool, Never> {
        return $libraryListVideo
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
    var vldLibraryListAR: AnyPublisher<Bool, Never> {
        return $libraryListAR
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

    func fetchDataLibrary(project_id: Int) {
        var param: [String: Any] = [:]

        if project_id != -1 {
            param["project_sale_id"] = project_id
        }

        LibraryService.libraryService(url: SaleUrl.library, param: param, method: .POST, header: Networking.shared.getHeader())
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
                    self.libraryListImage = value.list_image ?? []
                    self.libraryListVideo = value.list_video ?? []
                    self.libraryListAR = value.list_ar ?? []
                }).store(in: &disposables)
    }
}
