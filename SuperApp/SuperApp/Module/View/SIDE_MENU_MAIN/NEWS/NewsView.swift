// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import RxSwift
import SDWebImageSwiftUI

struct NewsTabb {
    var title: String
    var id: Int
    var image: String
    var TimeUpdate: String
}

struct TabbList {
    var uid: Int
    var name: String
}

struct NewsView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var isNext = false
    @State var selectedTab = 1
    @State var selectedTabOld = 1
    @State var newsUpdateTab = true
    @State var newsUpdateTabOld = true
    @State var selectedIndex = -2
    @State var isNextChat = false
    @State private var isShowing = false
    @State private var isInfinite = false
    @State var news_id = 0
    @State var isHasData = false
    @State var isHasDataTab = false
    @State var disposables = Set<AnyCancellable>()
    @ObservedObject var newsViewModel = NewsViewModel()
    @State var listCatesNews = [NewsCategoriesModel]()
    @State var listNews = [NewsListModel]()
    @State var tempPullScreen = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if tempPullScreen { Text("") }
                if self.selectedTab != self.selectedTabOld {
                    Text("").onAppear {
                        self.isHasData = false

                        self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)

                        self.newsViewModel.ListNews.sink { rs in
                            self.listNews = self.newsViewModel.newsList ?? []
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.isHasData = true
                            }
                        }.store(in: &self.disposables)

                        self.selectedTabOld = self.selectedTab
                    }
                }

                if self.newsUpdateTab != self.newsUpdateTabOld {
                    Text("").onAppear {
                        self.isHasData = false

                        self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)

                        self.newsViewModel.ListNews.sink { rs in
                            self.listNews = self.newsViewModel.newsList ?? []
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.isHasData = true
                            }
                        }.store(in: &self.disposables)

                        self.newsUpdateTabOld = self.newsUpdateTab
                    }
                }

                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                        .padding(.top, H(64))
                    if isHasDataTab {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack (spacing: 26) {
                                ForEach(listCatesNews, id: \.category_id) { news in
                                    NewsViewTab(selectedTab: self.$selectedTab,
                                        title: news.category_name ?? "",
                                        index: news.category_id ?? 0)
                                }
                            }.padding(.horizontal, 20)
                                .frame(height: H(41))
                        }
                    } else {
                        Rectangle().foregroundColor(.white)
                            .frame(width: 10, height: H(41))
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                    HStack (spacing: 7) {
                        NewsViewTabUpdate(newsUpdate: self.$newsUpdateTab, title: "news_newsPost", index: true)
                        Rectangle()
                            .foregroundColor(.init(#colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1)))
                            .frame(width: 1, height: H(18))
                        NewsViewTabUpdate(newsUpdate: self.$newsUpdateTab, title: "news_oldPost", index: false)
                        Spacer()
                    }.padding(.leading, 20)
                        .padding(.top, H(22))
                    List {
                        VStack (alignment: .leading, spacing: H(16)) {
                            if isHasData {
                                if listNews.count != 0 {
                                    VStack (alignment: .leading, spacing: H(16)) {
                                        ForEach (listNews.enumeratedArray(), id: \.element) { index, news in
                                            ListNew(
                                                index: news.news_id ?? 0,
                                                title: news.news_title ?? "",
                                                image: news.avatar_url ?? "",
                                                time: news.formatTime(),
                                                selectedIndex: self.$selectedIndex,
                                                isNext: self.$isNext,
                                                isSideMenuAppear: self.$isSideMenuAppear
                                            ).padding(.top, index == 0 ? H(12) : 0)
                                        }
                                    }
                                } else {
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "group9122", w: 219, h: 150)
                                            .padding(.top, H(92))
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.white)
                    }.padding(.top, H(12))
                        .background(PullToRefresh(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isHasData = false

                                    self.newsViewModel.page = 1
                                    self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)

                                    self.newsViewModel.ListNews.sink { rs in
                                        self.listNews = self.newsViewModel.newsList ?? []
                                        withAnimation(.easeInOut(duration: 0.2)) {
                                            self.isHasData = true
                                        }
                                        self.isShowing = false
                                    }.store(in: &self.disposables)
                                }
                        }, isShowing: self.$isShowing))
//                        .background(PullToRefreshView(action: {
//                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
//                                    self.isShowing = false
//                                    self.isHasData = false
//
//                                    self.newsViewModel.page = 1
//                                    self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)
//
//                                    self.newsViewModel.ListNews.sink { rs in
//                                        self.listNews = self.newsViewModel.newsList ?? []
//                                        withAnimation(.easeInOut(duration: 0.2)) {
//                                            self.isHasData = true
//                                        }
//                                    }.store(in: &self.disposables)
//                                }
//                }, isShowing: self.$isShowing, actionInfinite: {
//                                    self.newsViewModel.page += 1
//                                    if self.newsViewModel.page > self.newsViewModel.totalPage {
//                                        self.isInfinite = false
//                                    } else {
//                                        self.isInfinite = false
//                                        self.isHasData = false
//                                        DispatchQueue.main.asyncAfter(deadline: .now()) {
//                                            self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)
//                                            self.newsViewModel.isHasData.sink { rs in
//                                                self.listNews.append(contentsOf: self.newsViewModel.newsList ?? [])
//                                                self.isHasData = true
//                                            }.store(in: &self.disposables)
//                                        }
//                                    }
//                    self.isInfinite = false
//                }, infinite: self.$isInfinite)
//        )
                }
                Rectangle()
                    .opacity(isOpenSideMenu ? 0.75 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.closeSideMenu()
                }
                VStack {
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: $isOpenSideMenu,
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "news_title",
                        title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)",
                        backFunc: {
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                            self.closeSideMenu()
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: {
                            callPhone()
                            UIApplication.shared.endEditing()
                        },
                        textFunc: {
                            UIApplication.shared.endEditing()
                            self.closeSideMenu()
                            self.isNextChat = true
                            self.isSideMenuAppear = false
                        },
                        isCallAndTextBlack: true
                    )
                    Spacer()
                }
                NavigationLink(destination:
                        ChatView(
                            isNextOld: $isNextChat,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNextChat) {
                    EmptyView()
                }
                NavigationLink(destination:
                        NewsDetailView(
                            isNextOld: $isNext,
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectName: $projectName,
                            news_id: $selectedIndex,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.onAppear {
                self.tempPullScreen = true
                self.loadAPICategories()
                self.loadAPINews()
                UITableView.appearance().backgroundColor = .white
                UITableViewCell.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
            }.background(Color.white)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }

    func loadAPICategories() {
        self.newsViewModel.fetchDataListCategories(language: VIETNAM)

        self.newsViewModel.isHasData.sink { rs in
            self.listCatesNews = self.newsViewModel.newsListCategories ?? []
            withAnimation(.easeInOut(duration: 0.2)) {
                self.isHasDataTab = true
            }
        }.store(in: &self.disposables)
    }
    func loadAPINews() {
        self.newsViewModel.fetchDataNewsList(project_id: self.project_id, category_id: self.selectedTab, latest_flag: self.newsUpdateTab)

        self.newsViewModel.ListNews.sink { rs in
            self.listNews = self.newsViewModel.newsList ?? []
            withAnimation(.easeInOut(duration: 0.2)) {
                self.isHasData = true
            }
        }.store(in: &self.disposables)
    }
}

struct ListNew: View {
    @State var index = 0
    var title = ""
    var image = ""
    var time = ""
    @Binding var selectedIndex: Int
    @Binding var isNext: Bool
    @Binding var isSideMenuAppear: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: H(16)) {
            Button(action: {
                self.selectedIndex = self.index
                self.isNext = true
                self.isSideMenuAppear = false
            }) {
                HStack (spacing: 18) {
                    ZStack {
                        if image.isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: image))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: W(99), height: W(85))
                        .clipped()
                        .cornerRadius(4)
                        .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 5)
                    VStack (alignment: .leading, spacing: 0) {
                        TextCustom(text: title.isEmpty ? "-" : title, font: REGULAR, size: 16, lineLimit: 3, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                            .fixedSize(horizontal: false, vertical: true)
                        Spacer()
                        HStack(spacing: 8) {
                            ImageCustom(name: "clock_purple", w: 13.6, h: 13.6)
                            TextCustom(text: time.isEmpty ? "__:__ __/__/___" : time, size: 12, color: #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1))
                        }
                    }.frame(height: H(85))
                }.padding(.horizontal, 20)
                    .background(Color.white)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .background(Color.white)
            Rectangle()
                .frame(height: H(1))
                .foregroundColor(.init(#colorLiteral(red: 0.9018655419, green: 0.9020171762, blue: 0.9018443227, alpha: 1)))
                .padding(.horizontal, 20)
        }
    }
}

struct NewsViewTab: View {
    @Binding var selectedTab: Int
    @State var title = ""
    @State var index = 0

    var body: some View {
        ZStack {
            Button(action: {
                self.selectedTab = self.index
            }) {
                TextCustom(text: title, font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
            }.buttonStyle(ButtonTapScale())
                .opacity(selectedTab == index ? 1 : 0)

            Button(action: {
                self.selectedTab = self.index
            }) {
                TextCustom(text: title, font: REGULAR, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
            }.buttonStyle(ButtonTapScale())
                .opacity(selectedTab == index ? 0 : 1)
        }.animation(.easeInOut(duration: 0.1))

    }
}

struct NewsViewTabUpdate: View {
    @Binding var newsUpdate: Bool
    @State var title = ""
    @State var index = true

    var body: some View {
        ZStack {
            Button(action: {
                self.newsUpdate = self.index
            }) {
                TextCustom(text: NSLocalizedString(title, comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
            }.buttonStyle(ButtonTapScale())
                .opacity(newsUpdate == index ? 1 : 0)

            Button(action: {
                self.newsUpdate = self.index
            }) {
                TextCustom(text: NSLocalizedString(title, comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
            }.buttonStyle(ButtonTapScale())
                .opacity(newsUpdate == index ? 0 : 1)
        }.animation(.easeInOut(duration: 0.1))

    }
}
