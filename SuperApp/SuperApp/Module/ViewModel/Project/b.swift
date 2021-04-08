////
////  test.swift
////  SuperApp
////
////  Created by MacOs on 4/22/20.
////  Copyright © 2020 Tran Thien Phu. All rights reserved.
////
//
//import Foundation
//import Combine
//import RxSwift
//
//class ProjectListViewModel : ObservableObject , BaseViewModelProtocol{
//    public let didChange = PassthroughSubject<ProjectListViewModel, Never>()
//    private var disposables = Set<AnyCancellable>()
//    @Published var data: [ProjectListResponeModel] = [] {
//        didSet {
//            didChange.send(self)
//        }
//    }
//    var dataManager: BaseViewModelProtocol
//    var signalPush: PublishSubject<Bool> = PublishSubject<Bool>()
//    init(dataManager: BaseViewModelProtocol = BaseViewModel.shared) {
//        self.dataManager = dataManager
//    }
//
//    func fetchData(){
//        let param: [String: Any] = ["project_name": ""]
//
//        data = dataManager.doPost(url: Project.projectList, param: param, method: .POST, header: Networking.shared.getHeader())
////            .map {($0)}
////        .receive(on: DispatchQueue.main)
////        .sink(receiveCompletion: { [weak self] value in
////            guard self != nil else { return }
////
////            switch value {
////            case .failure:
////                print("Error")
////            case .finished:
////                return
////            }
////            }, receiveValue: { [weak self] value in
////                guard let self = self else { return }
//////                data
////                //            guard let _value = value else {return}
////        })
////            .store(in: &disposables)
//    }
//}
