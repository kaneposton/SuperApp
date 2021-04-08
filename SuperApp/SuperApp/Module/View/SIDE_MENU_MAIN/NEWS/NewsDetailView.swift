// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI
import Combine

struct NewsDetailView: View {
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var news_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]

    @State var isNextChat = false
    @State var isHaveData = false
    @State var disposables = Set<AnyCancellable>()
    @State var newsdetaildata = NewsDetailModel()
    @State var isShowing = false
    @State var tempPullScreen = false

    @ObservedObject var newsviewmodel = NewsViewModel()

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if tempPullScreen { Text("") }
                VStack(alignment: .leading, spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.9097078443, green: 0.9098607302, blue: 0.9096864462, alpha: 1)))
                        .padding(.top, H(64))
                    List {
                        VStack(alignment: .leading, spacing: 0) {
                            if isHaveData {
                                TextCustom(text: "\(newsdetaildata.new_title ?? "")", font: MEDIUM, size: 18, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 20)
                                    .padding(.top, H(19))
                                TextCustom(text: "\(newsdetaildata.new_description ?? "")", font: ITALIC, size: 16, color: #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.horizontal, 20)
                                    .padding(.vertical, H(16))
                                ZStack {
                                    if (newsdetaildata.thumbnail_url ?? "").isEmpty {
                                        Image("default_medium")
                                            .resizable()
                                    } else {
                                        ZStack {
                                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                            WebImage(url: URL(string: "\(newsdetaildata.thumbnail_url ?? "")"))
                                                .resizable()
                                        }
                                    }
                                }.scaledToFill()
                                    .frame(width: FULL_W, height: H(255))
                                    .clipped()
                                TextCustom(text: "\(newsdetaildata.new_content ?? "")", font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                    .fixedSize(horizontal: false, vertical: true)
                                    .padding(.top, H(16))
                                    .padding(.horizontal, 20)
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.white)
                    }.background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.isHaveData = false
                            self.newsviewmodel.fetchDataNewsDetail(news_id: self.news_id)
                            self.newsviewmodel.ListNewsDetail.sink { rs in
                                self.newsdetaildata = self.newsviewmodel.newsDetail ?? NewsDetailModel()
                                withAnimation(.easeInOut(duration: 0.2)) {
                                    self.isHaveData = true
                                }
                                self.isShowing = false
                            }.store(in: &self.disposables)
                        }
                    }, isShowing: self.$isShowing))
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
                            self.isSideMenuAppear = true
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
                            arrChatData: $arrChatData,
                            isHaveSideMenu: false
                        ), isActive: $isNextChat) {
                    EmptyView()
                }
            }.onAppear {
                self.tempPullScreen = true
                UITableViewCell.appearance().backgroundColor = .white
                UITableView.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
                self.newsviewmodel.fetchDataNewsDetail(news_id: self.news_id)
                self.newsviewmodel.ListNewsDetail.sink { rs in
                    self.newsdetaildata = self.newsviewmodel.newsDetail ?? NewsDetailModel()
                    self.isHaveData = true
                }.store(in: &self.disposables)
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
