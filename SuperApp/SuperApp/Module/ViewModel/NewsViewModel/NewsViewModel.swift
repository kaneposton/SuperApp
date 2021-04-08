//
//  NewsViewModel.swift
//  SuperApp
//
//  Created by Linh on 4/29/20.
//  Copyright © 2020 Tran Thien Phu. All rights reserved.
//

import SwiftUI
import Combine
import RxSwift
import Foundation
protocol NewsViewModelProtocol {
    var didChange: PassthroughSubject<NewsViewModel, Never> { get }
    var ListCategory: AnyPublisher <[NewsCategoriesModel]?, Never> { get }
    var ListNews : AnyPublisher<[NewsListModel]? , Never> { get }
    var ListNewsDetail : AnyPublisher<NewsDetailModel?, Never> { get }
    func fetchDataListCategories(language: Int)
    func fetchDataNewsList(project_sale_id: Int,category_id: Int,latest_flag:Bool)
    func fetchDataNewsDetail(news_id: Int)
}
class NewsViewModel: ObservableObject, NewsViewModelProtocol {

    public let didChange = PassthroughSubject<NewsViewModel, Never>()
    @Published var newsListCategories: [NewsCategoriesModel]?
    @Published var newsList : [NewsListModel]?
    @Published var newsDetail: NewsDetailModel?
    @Published var isHaveData : Bool = false {
        willSet{
            didChange.send(self)
        }
    }
     init (){
        fetchDataListCategories(language: 1)
        fetchDataNewsList(project_sale_id: 13, category_id: 3, latest_flag: true)
    }
    private var disposable = Set<AnyCancellable>()
    
    var ListCategory: AnyPublisher<[NewsCategoriesModel]?, Never> {
        return $newsListCategories
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                return Future { promise in
                    if list != nil {
                        promise(.success(list))
                    } else {
                        promise(.success(nil))

                    }
                }
        }
    .switchToLatest()
    .eraseToAnyPublisher()
    }
    
    //
    var ListNews: AnyPublisher<[NewsListModel]?, Never>{
        return $newsList
            .debounce(for: 0.5, scheduler: RunLoop.main)
        .removeDuplicates()
        .map { list in
                   return Future { promise in
                       if list != nil {
                           promise(.success(list))
                       } else {
                           promise(.success(nil))

                       }
                   }
           }
    .switchToLatest()
    .eraseToAnyPublisher()
    }
    //
    
    var ListNewsDetail: AnyPublisher<NewsDetailModel?, Never>
        {
        return $newsDetail
        .debounce(for: 0.5, scheduler: RunLoop.main)
            .removeDuplicates()
            .map { list in
                       return Future { promise in
                           if list != nil {
                               promise(.success(list))
                           } else {
                               promise(.success(nil))

                           }
                       }
               }
        .switchToLatest()
        .eraseToAnyPublisher()
    }
    //
    func fetchDataListCategories(language: Int) {
        let param : [String : Any] = ["language" : language]
        NewsService.NewsCategoriesService(url: NewsURL.categoriesURL, param: param, method: .POST, header: Networking.shared.getHeader())
            .map{($0.list)}
        .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                guard self != nil else {return}
                switch value {
                case.failure:
                    print("error")
                case.finished :
                    return
                }
            }) { [weak self] value in
                guard let self = self else {return}
                self.newsListCategories = value
               
        }
    .store(in: &disposable)
    }
    //
    func fetchDataNewsList(project_sale_id: Int, category_id: Int, latest_flag: Bool) {
        let param : [String : Any] = ["project_sale_id" :project_sale_id , "category_id" : category_id, "latest_flag" :latest_flag ]
        NewsService.NewsListService(url: NewsURL.listNewsURL, param: param, method: .POST, header: Networking.shared.getHeader())
        
        .map{($0.list)}
            .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] value in
                    guard self != nil else {return}
                    switch value {
                    case.failure:
                        print("error")
                    case.finished :
                        return
                    }
                }) { [weak self] value in
                    guard let self = self else {return}
                    self.newsList = value
                    
            }
        .store(in: &disposable)
       }
    //
    func fetchDataNewsDetail(news_id: Int) {
        let param : [String : Any] = ["news_id" : news_id]
        
        NewsService.NewsListDetailService(url: NewsURL.NewsDetailURL, param: param, method: .POST, header: Networking.shared.getHeader())
        .map{($0)}
            .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { [weak self] value in
                    guard self != nil else {return}
                    switch value {
                    case.failure:
                        print("error")
                    case.finished :
                        return
                    }
                }) { [weak self] value in
                    guard let self = self else {return}
                    self.newsDetail = value
            }
        .store(in: &disposable)
        
       }
    
}

