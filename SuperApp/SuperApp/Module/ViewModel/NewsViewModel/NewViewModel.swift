// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import RxSwift
import Foundation

protocol NewsViewModelProtocol {
    var didChange: PassthroughSubject<NewsViewModel, Never> { get }
    var disposable: Set<AnyCancellable> { get }
    func fetchDataListCategories(language: Int)
    func fetchDataNewsList(project_id: Int, category_id: Int, latest_flag: Bool)
    func fetchDataNewsDetail(news_id: Int)
}

class NewsViewModel: ObservableObject, NewsViewModelProtocol {
    var disposable = Set<AnyCancellable> ()
    @Published var newsListCategories: [NewsCategoriesModel]?
    @Published var newsList: [NewsListModel]?
    @Published var newsDetail: NewsDetailModel?

    var didChange = PassthroughSubject<NewsViewModel, Never>()
    var page = 1
    var totalPage = 1

    var isHasData: AnyPublisher<Bool, Never> {
        return $newsListCategories
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

    var ListNews: AnyPublisher<[NewsListModel]?, Never> {
        return $newsList
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

    var ListNewsDetail: AnyPublisher<NewsDetailModel?, Never> {
        return $newsDetail
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

    //MARK: CATEGORIES
    func fetchDataListCategories(language: Int) {
        let param: [String: Any] = ["language": language]
        NewsService.NewsCategoriesService(url: NewsURL.categoriesURL, param: param, method: .POST, header: Networking.shared.getHeader())
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
                self.newsListCategories = value
            }.store(in: &disposable)
    }

    //MARK: NEWS
    func fetchDataNewsList(project_id: Int, category_id: Int, latest_flag: Bool) {
        let param: [String: Any] = ["project_sale_id": project_id, "category_id": category_id, "latest_flag": latest_flag, "page": self.page]
        NewsService.NewsListService(url: NewsURL.listNewsURL, param: param, method: .POST, header: Networking.shared.getHeader())
            .map { ($0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case.failure: print("error")
                case.finished: return
                }
            }) { [weak self] value in
                guard let self = self else { return }
                self.newsList = Array.removeDuplicates(value.list!)
                self.totalPage = value.total_pages!
            }.store(in: &disposable)
    }

    //MARK: DETAIL
    func fetchDataNewsDetail(news_id: Int) {
        let param: [String: Any] = ["news_id": news_id]

        NewsService.NewsListDetailService(url: NewsURL.NewsDetailURL, param: param, method: .POST, header: Networking.shared.getHeader())
            .map { ($0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else { return }
                switch value {
                case.failure: print("error")
                case.finished: return
                }
            }) { [weak self] value in
                guard let self = self else { return }
                self.newsDetail = value
            }.store(in: &disposable)
    }
}
