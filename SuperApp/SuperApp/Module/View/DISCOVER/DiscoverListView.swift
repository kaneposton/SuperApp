// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI
import Combine

struct DiscoverListView: View {
    @Binding var isNextOld: Bool
    @State var discoverDataArr: [HomeDiscoverListModel]
    let closeSideMenu: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @State var strSearch = ""
    @State var detail = ""
    @State var isNext = false

    // MARK: PRIVINCE ID CHO FILTER
    @State var provinceId = 0

    @State var isShowing = false
    @State var isInfinite = false
    @State var disposables = Set<AnyCancellable>()
    @State var isShowData = true
    @State var tempPullScreen = false

    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                if tempPullScreen { Text("") }
                VStack (alignment: .leading, spacing: 0) {
                    // MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "home_discover",
                        backFunc: {
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchAlwaysAppear: true
                    )

                    // MARK: BODY
                    ZStack (alignment: .top) {
                        VStack {
                            Spacer()
                        }
                        if isShowData {
                            List {
                                VStack (alignment: .leading, spacing: 0) {
                                    if discoverDataArr.count > 0 {
                                        if strSearch.isEmpty {
                                            VStack(spacing: H(20)) {
                                                ForEach(discoverDataArr, id: \.self) { data in
                                                    DiscoverListContentView(detail: self.$detail, isNext: self.$isNext, provinceId: self.$provinceId, data: data)
                                                }
                                            }
                                        } else if discoverDataArr.firstIndex(where: ({ ($0.province_name ?? "").localizedStandardContains(strSearch) })) == nil {
                                            ImageCustom(name: "NoResult", w: 219, h: 150)
                                                .padding(.top, H(100))
                                        } else {
                                            VStack(spacing: H(20)) {
                                                ForEach(discoverDataArr.filter({ ($0.province_name ?? "").localizedStandardContains(strSearch) }), id: \.self) { data in
                                                    DiscoverListContentView(detail: self.$detail, isNext: self.$isNext, provinceId: self.$provinceId, data: data)
                                                }
                                            }
                                        }
                                    } else {
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                            .padding(.top, H(100))
                                    }
                                }.padding(.top, H(10))
                                    .padding(.horizontal, 20)
                                    .listRowInsets(EdgeInsets())
                                    .background(Color.white)
                                    .padding(.bottom, H(30))
                                    .frame(width: FULL_W)
                                    .edgesIgnoringSafeArea(.bottom)
                            }.resignKeyboardOnDragGesture()
                                .frame(width: FULL_W)
                                .background(PullToRefresh(action: {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                            withAnimation(.easeInOut(duration: 0.15)) {
                                                self.isShowData = false
                                            }
                                            self.homeViewModel.fetchDataDiscover()

                                            self.homeViewModel.vldListDiscoverBool.sink { rs in
                                                self.discoverDataArr = self.homeViewModel.homeDiscoverList ?? []
                                                withAnimation(.easeInOut(duration: 0.15)) {
                                                    self.isShowData = true
                                                }
                                                self.isShowing = false
                                            }.store(in: &self.disposables)
                                        }
                                }, isShowing: self.$isShowing))
                        }
                    }
                }
                NavigationLink(destination:
                        DiscoverDetailView(
                            isNextOld: $isNext,
                            detail: $detail,
                            closeSideMenu: { self.closeSideMenu() },
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            isNextSideMenu: $isNextSideMenu,
                            selectedMenuPurple: $selectedMenuPurple,
                            selectedCorlor: $selectedCorlor,
                            provinceId: provinceId
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.onAppear {
                    self.tempPullScreen = true
                    UITableViewCell.appearance().backgroundColor = .white
                    UITableView.appearance().backgroundColor = .white
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().showsVerticalScrollIndicator = false
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }.edgesIgnoringSafeArea(.bottom)
                .background(Color.white)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct DiscoverListContentView: View {
    @Binding var detail: String
    @Binding var isNext: Bool
    @Binding var provinceId: Int
    @State var data: HomeDiscoverListModel

    var body: some View {
        Button(action: {
            self.provinceId = self.data.province_id ?? 0
            self.detail = self.data.province_name ?? ""
            self.isNext = true
        }) {
            ZStack (alignment: .bottomLeading) {
                ZStack {
                    if (data.province_avatar ?? "").isEmpty {
                        Image("default_medium")
                            .resizable()
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                            WebImage(url: URL(string: "\(data.province_avatar ?? "")"))
                                .resizable()
                        }
                    }
                }.scaledToFill()
                    .frame(width: FULL_W - 40, height: H(160))
                    .clipped()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: H(160))
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.368627451, green: 0.2078431373, blue: 0.5333333333, alpha: 0.6456549658)), .init(#colorLiteral(red: 0.368627451, green: 0.2078431373, blue: 0.5333333333, alpha: 0.05835295377)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.8, alpha: 0))]), startPoint: .bottom, endPoint: .top))
                VStack (alignment: .leading, spacing: H(6.5)) {
                    TextCustom(text: data.province_name ?? "", font: MEDIUM, size: 24, lineLimit: 1, color: #colorLiteral(red: 0.9897719026, green: 0.9898901582, blue: 0.989731729, alpha: 1))
                    TextCustom(text: "\(data.total_project ?? 0) \(NSLocalizedString("home_project", comment: ""))", font: LIGHT_ITALIC, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.9897719026, green: 0.9898901582, blue: 0.989731729, alpha: 1))
                }.frame(width: W(298), alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, H(14))
            }.cornerRadius(7)
                .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 3)
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
    }
}
