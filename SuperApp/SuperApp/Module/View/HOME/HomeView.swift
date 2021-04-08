// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI
import Combine
import Mapbox

struct HomeView: View {
    @Binding var isLogin: Bool

    // MARK: FLAG INIT
    @Binding var isInit: Bool

    // MARK: SPLASH SCREEN
    @Binding var isAlreadySplash: Bool

    // MARK: CÁC BIẾN BINDING CỦA SIDE MENU TÍM
    let closeSideMenu: () -> Void
    @Binding var isAppearItem: Bool
    @Binding var animation: Bool
    @Binding var isTabBarAppear: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int

    @State var isStartHome = false
    @State var viewStateHome = CGSize.zero
    @State var pictureHomeIndex: CGFloat = 0
    @State var saveWidthHome: CGFloat = 0
    @State var spaceImageHome: CGFloat = 346
    @State var isNextMap = false
    @State var isNextFilter = false
    @State var isNextDiscover = false
    @State var isNextDiscoverDetail = false
    @State var isNextProjectDetailHomeList = false
    @State var detailDiscover = ""
    @State var isNextProjectHome = false
    @State var projectName = ""
    @State var coorDinate = DataForMap(title: "", location: CLLocationCoordinate2D(latitude: 0, longitude: 0), projectId: 0, stringName: "", stringAddress: "")

    @State var project_id = -1
    @State var projectURL = ""

    @State var provinceId = 0
    @State var isDoneFetchDiscover = false
    @State var isDoneFetchProjectList = false
    @State var isDoneFetchProductSelling = false
    @State var disposables = Set<AnyCancellable>()

    @State var isShowing = false

    @EnvironmentObject private var homeViewModel: HomeViewModel

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                // MARK: ẨN TAB BAR KHI GẶP CÁC ĐIỀU KIỆN NÀY
                if isNextFilter || isNextDiscover || isNextDiscoverDetail || isNextProjectDetailHomeList || isNextMap || isNextProjectHome {
                    Text("").onAppear { self.isTabBarAppear = false }
                }

                // MARK: MỞ TAB BAR KHI THOẢ TẤT CẢ CÁC ĐIỀU KIỆN NÀY
                if !isNextFilter && !isNextDiscover && !isNextDiscoverDetail && !isNextProjectDetailHomeList && !isNextMap && !isNextProjectHome {
                    Text("").onAppear { self.isTabBarAppear = true }
                }
                VStack (spacing: 0) {
                    // MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: $isLogin,
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        backFunc: { },
                        mapFunc: { self.isNextMap = true },
                        filterFunc: { self.isNextFilter = true },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isHome: true
                    )

                    // MARK: NỘI DUNG
                    List {
                        VStack (spacing: 0) {
                            // MARK: KHÁM PHÁ ==============================
                            HStack {
                                TextCustom(text: NSLocalizedString("home_discover", comment: ""), size: 24, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                Spacer()
                                Button(action: {
                                    self.isNextDiscover = true
                                }) {
                                    ImageCustom(name: "arrowPurple", w: 24, h: 24)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                // MARK: NẾU KHÔNG CÓ DATA THÌ KHÔNG HIỂN THỊ ICON "->"
//                                .opacity(isDoneFetchDiscover && (homeViewModel.homeDiscoverList ?? []).count > 0 ? 1 : 0)
                            }.padding(.horizontal, 20)

                            // MARK: TRƯỚC KHI FETCH DATA
                            if !isDoneFetchDiscover {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: H(206))
                            } else { // MARK: SAU KHI FETCH DATA
                                // MARK: NẾU CÓ DATA THÌ HIỆN HSCROLL
                                if (homeViewModel.homeDiscoverList ?? []).count > 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack (spacing: 16) {
                                            ForEach(homeViewModel.homeDiscoverList ?? [], id: \.self) { data in
                                                DiscoverScroll(detailDiscover: self.$detailDiscover, provinceId: self.$provinceId, isNextDiscoverDetail: self.$isNextDiscoverDetail, dataDiscover: data)
                                            }
                                        }.padding(.horizontal, 20)
                                            .frame(height: H(184))
                                    }.padding(.top, H(4))
                                        .padding(.bottom, H(18))
                                } else { // MARK: CÒN KHÔNG CÓ DATA THÌ HIỆN IMAGE "KHÔNG CÓ KẾT QUẢ"
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                        Spacer()
                                    }.frame(height: H(184))
                                        .padding(.top, H(4))
                                        .padding(.bottom, H(18))
                                }
                            }

                            // MARK: DANH SÁCH DỰ ÁN ==============================
                            HStack {
                                TextCustom(text: NSLocalizedString("home_project_list", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                Spacer()
                                Button(action: {
                                    self.isNextProjectDetailHomeList = true
                                }) {
                                    ImageCustom(name: "arrowPurple", w: 24, h: 24)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                // MARK: NẾU KHÔNG CÓ DATA THÌ KHÔNG HIỂN THỊ ICON "->"
                                .opacity(isDoneFetchProjectList && (homeViewModel.homeProjectList ?? []).count > 0 ? 1 : 0)
                            }.padding(.horizontal, 20)

                            // MARK: TRƯỚC KHI FETCH DATA
                            if !isDoneFetchProjectList {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: H(251))
                            } else { // MARK: SAU KHI FETCH DATA
                                // MARK: NẾU CÓ DATA THÌ HIỆN HSCROLL
                                if (homeViewModel.homeProjectList ?? []).count > 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack (spacing: 16) {
                                            ForEach((homeViewModel.homeProjectList ?? []), id: \.self) { data in
                                                ProjectScroll(projectURL: self.$projectURL, project_id: self.$project_id, projectName: self.$projectName, isNextProjectHome: self.$isNextProjectHome, dataProject: data)
                                            }
                                        }.padding(.horizontal, 20)
                                            .frame(height: H(238))
                                    }.padding(.bottom, H(13))
                                } else { // MARK: CÒN KHÔNG CÓ DATA THÌ HIỆN IMAGE "KHÔNG CÓ KẾT QUẢ"
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                        Spacer()
                                    }.frame(height: H(238))
                                        .padding(.bottom, H(13))
                                }
                            }

                            // MARK: SẢN PHẨM NỔI BẬT ==============================
                            HStack {
                                TextCustom(text: NSLocalizedString("home_recommend_house", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                Spacer()
                                Button(action: {

                                }) {
                                    ImageCustom(name: "arrowPurple", w: 24, h: 24)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                // MARK: NẾU KHÔNG CÓ DATA THÌ KHÔNG HIỂN THỊ ICON "->"
                                .opacity(isDoneFetchProductSelling && (homeViewModel.homeProductSellingList ?? []).count > 0 ? 1 : 0)
                            }.padding(.horizontal, 20)

                            // MARK: TRƯỚC KHI FETCH DATA
                            if !isDoneFetchProductSelling {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(height: H(270))
                            } else { // MARK: SAU KHI FETCH DATA
                                // MARK: NẾU CÓ DATA THÌ HIỆN HSCROLL
                                if homeViewModel.homeProductSellingList?.count ?? 0 > 0 {
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack (spacing: 16) {
                                            ForEach(homeViewModel.homeProductSellingList ?? [], id: \.self) { data in
                                                HouseScroll(dataSelling: data)
                                            }
                                        }.padding(.horizontal, 20)
                                            .frame(height: H(250))
                                    }.padding(.bottom, H(20))
                                } else { // MARK: CÒN KHÔNG CÓ DATA THÌ HIỆN IMAGE "KHÔNG CÓ KẾT QUẢ"
                                    HStack {
                                        Spacer()
                                        ImageCustom(name: "NoResult", w: 219, h: 150)
                                        Spacer()
                                    }.frame(height: H(250))
                                        .padding(.bottom, H(20))
                                }
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.white)
                            .animation(.easeInOut(duration: 0.2))
                            .padding(.bottom, H(
                                FULL_H == H_SE && FULL_W == W_SE ? 95: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 80: // iPhone 8 &&v iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 75: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 65: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 70 : 0 // iPhone 11 Pro
                                    ))
                    }.background(PullToRefresh(action: {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                self.isDoneFetchDiscover = false
                                self.isDoneFetchProjectList = false
                                self.isDoneFetchProductSelling = false
                            }
                            // MARK: KHÁM PHÁ
                            self.homeViewModel.fetchDataDiscover()

                            // MARK: DANH SÁCH DỰ ÁN
                            self.homeViewModel.fetchDataProjectList(
                                settingType: [0],
                                provinceId: [],
                                projectStatus: [0, 1],
                                language: VIETNAM,
                                districtId: []
                            )

                            // MARK: SẢN PHẨM NỔI BẬT
                            self.homeViewModel.fetchDataProductSelling(language: VIETNAM)

                            self.homeViewModel.vldShowData.sink { rs1 in
                                self.isShowing = false
                                withAnimation(.easeInOut(duration: 0.15)) {
                                    self.isDoneFetchDiscover = true
                                    self.isDoneFetchProjectList = true
                                    self.isDoneFetchProductSelling = true
                                }
                            }.store(in: &self.disposables)
                        }
                    }, isShowing: self.$isShowing))
                }

                // MARK: NAVIGATION LINK
                ZStack (alignment: . top) {
                    //MARK: MÀN HÌNH TÌM KIẾM - LỌC
                    NavigationLink(destination:
                            SearchFilterView(
                                // MARK: MAP
                                isTapFilter: Binding.constant(false),
                                // MARK: SIDE MENU
                                closeSideMenu: { self.closeSideMenu() },
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                isNextOld: $isNextFilter,
                                isFilter: Binding.constant(false),
                                selectedStatusMap: Binding.constant([]),
                                selectedCityMap: Binding.constant([]),
                                selectedProvinceMap: Binding.constant([]),
                                selectedDistrictMap: Binding.constant([]),
                                selectedDistrictIDMap: Binding.constant([])
                            ), isActive: $isNextFilter) {
                        EmptyView()
                    }

                    // MARK: MÀN HÌNH BẢN ĐỒ
                    NavigationLink(destination:
                            MapView(
                                closeSideMenu: { self.closeSideMenu() },
                                projectName: $projectName,
                                isNextOld: $isNextMap,
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                localDataMap: convertToArrDataForMap(data: homeViewModel.homeProjectList ?? []),
                                coorDinate: coorDinate,
                                listData: homeViewModel.homeProjectList ?? []
                            ), isActive: $isNextMap) {
                        EmptyView()
                    }

                    // MARK: MÀN HÌNH DANH SÁCH TỈNH THÀNH - KHÁM PHÁ
                    NavigationLink(destination:
                            DiscoverListView(
                                isNextOld: $isNextDiscover,
                                discoverDataArr: self.homeViewModel.homeDiscoverList ?? [],
                                closeSideMenu: { self.closeSideMenu() },
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                provinceId: provinceId
                            ).environmentObject(homeViewModel),
                        isActive: $isNextDiscover) {
                        EmptyView()
                    }

                    // MARK: MÀN HÌNH DANH SÁCH DỰ ÁN CỦA MỘT TỈNH THÀNH
                    NavigationLink(destination:
                            DiscoverDetailView(
                                isNextOld: $isNextDiscoverDetail,
                                detail: $detailDiscover,
                                closeSideMenu: { self.closeSideMenu() },
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                provinceId: provinceId
                            ), isActive: $isNextDiscoverDetail) {
                        EmptyView()
                    }

                    // MARK: MÀN HÌNH DANH SÁCH TẤT CẢ DỰ ÁN
                    NavigationLink(destination:
                            ProjectDetailHomeListView(
                                closeSideMenu: { self.closeSideMenu() },
                                isNextOld: $isNextProjectDetailHomeList,
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                listData: homeViewModel.homeProjectList ?? []
                            ), isActive: $isNextProjectDetailHomeList) {
                        EmptyView()
                    }

                    // MARK: MÀN HÌNH CHI TIẾT DỰ ÁN - TRANG CHỦ
                    NavigationLink(destination:
                            ProjectHomeView(
                                closeSideMenu: { self.closeSideMenu() },
                                projectURL: $projectURL,
                                projectName: $projectName,
                                isNextOld: $isNextProjectHome,
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNextSideMenu: $isNextSideMenu,
                                selectedMenuPurple: $selectedMenuPurple,
                                selectedCorlor: $selectedCorlor,
                                project_id: $project_id
                            ), isActive: $isNextProjectHome) {
                        EmptyView()
                    }
                }
            }.onDisappear {
                self.isInit = true
            }.onAppear {
                if self.isInit {
                    // MARK: KHÁM PHÁ
                    self.homeViewModel.fetchDataDiscover()

                    // MARK: DANH SÁCH DỰ ÁN
                    self.homeViewModel.fetchDataProjectList(
                        settingType: [0],
                        provinceId: [],
                        projectStatus: [0, 1],
                        language: VIETNAM,
                        districtId: []
                    )

                    // MARK: SẢN PHẨM NỔI BẬT
                    self.homeViewModel.fetchDataProductSelling(language: VIETNAM)
                }
                UITableViewCell.appearance().backgroundColor = .white
                UITableView.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
                self.homeViewModel.vldShowData.sink { rs1 in
                    self.isDoneFetchDiscover = true
                    self.isDoneFetchProjectList = true
                    self.isDoneFetchProductSelling = true

                    if (self.homeViewModel.homeProjectList ?? []).count != 0 {
                        self.coorDinate = convertToDataForMap(data: (self.homeViewModel.homeProjectList ?? [])[0])
                    }
                }.store(in: &self.disposables)
            }.edgesIgnoringSafeArea(.bottom)
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct DiscoverScroll: View {
    @Binding var detailDiscover: String
    @Binding var provinceId: Int
    @Binding var isNextDiscoverDetail: Bool
    @State var dataDiscover: HomeDiscoverListModel?

    var body: some View {
        Button(action: {
            self.provinceId = self.dataDiscover?.province_id ?? 0
            self.detailDiscover = self.dataDiscover?.province_name ?? ""
            self.isNextDiscoverDetail = true
        }) {
            ZStack (alignment: .bottomLeading) {
                ZStack {
                    if (dataDiscover?.province_avatar ?? "").isEmpty {
                        Image("default_medium")
                            .resizable()
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                            WebImage(url: URL(string: dataDiscover?.province_avatar ?? ""))
                                .resizable()
                        }
                    }
                }.scaledToFill()
                    .frame(width: W(330), height: H(160))
                    .clipped()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: W(330), height: H(160))
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.368627451, green: 0.2078431373, blue: 0.5333333333, alpha: 0.6456549658)), .init(#colorLiteral(red: 0.368627451, green: 0.2078431373, blue: 0.5333333333, alpha: 0.05835295377)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.8, alpha: 0))]), startPoint: .bottom, endPoint: .top))
                VStack (alignment: .leading, spacing: 6.5) {
                    TextCustom(text: dataDiscover?.province_name ?? "", font: MEDIUM, size: 24, lineLimit: 1, color: #colorLiteral(red: 0.9897719026, green: 0.9898901582, blue: 0.989731729, alpha: 1))
                    TextCustom(text: "\(dataDiscover?.total_project ?? 0) \(NSLocalizedString("home_project", comment: ""))", font: LIGHT_ITALIC, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.9897719026, green: 0.9898901582, blue: 0.989731729, alpha: 1))
                }.frame(width: W(298), alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.bottom, H(14))
            }.cornerRadius(7)
                .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
    }
}

struct ProjectScroll: View {
    @Binding var projectURL: String
    @Binding var project_id: Int
    @Binding var projectName: String
    @Binding var isNextProjectHome: Bool
    @State var dataProject: HomeProjectListModel?

    @State var commaDistrict = ""

    var body: some View {
        Button(action: {
            self.project_id = self.dataProject?.project_id ?? 0
            self.projectName = self.dataProject?.project_name ?? ""
            self.projectURL = self.dataProject?.project_avatar_url ?? ""
            self.isNextProjectHome = true
        }) {
            VStack (alignment: .leading, spacing: 0) {
                ZStack (alignment: .topLeading) {
                    ZStack {
                        if (dataProject?.project_avatar_url ?? "").isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: dataProject?.project_avatar_url ?? ""))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: W(220), height: H(127))
                        .clipped()
                        .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                    ZStack (alignment: .leading) {
                        ImageCustom(name: dataProject?.is_sell ?? false ? "greenHomeFlag" : "orangeHomeFlag", w: 74, h: 24)
                            .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921)), radius: 2, y: 2)
                        TextCustom(text: NSLocalizedString(dataProject?.is_sell ?? false ? "search_isSell" : "search_isSellSoon", comment: ""), font: REGULAR, size: 11, color: .white)
                            .padding(.leading, 8.5)
                    }.padding(.top, 10)
                }.cornerRadius(7)
                    .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                    .padding(.bottom, H(12))
                TextCustom(text: dataProject?.project_name ?? "", font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    .padding(.bottom, H(7))
                    .frame(width: W(210), alignment: .leading)
                ZStack (alignment: .leading) {
                    HStack {
                        ImageCustom(name: "locationBlue", w: 14, h: 14)
                        Spacer()
                    }
                    TextCustom(text: "\((dataProject?.district_name ?? ""))\(commaDistrict)\((dataProject?.province_name ?? ""))", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        .padding(.leading, 20)
                        .frame(width: W(210), alignment: .leading)
                }.frame(width: W(220))
                    .padding(.bottom, H(7))
                ZStack (alignment: .leading) {
                    HStack {
                        ImageCustom(name: "timeBlue", w: 16, h: 16)
                        Spacer()
                    }
                    TextCustom(text: "\(dataProject?.sale_open_name ?? ""): \((dataProject?.date_opened ?? "").formatDate(from: "yyyy-MM-dd", to: "dd/MM/yyyy"))", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        .padding(.leading, 20)
                        .frame(width: W(210), alignment: .leading)
                }.frame(width: W(220))
            }
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
            .onAppear {
                self.commaDistrict = (self.dataProject?.district_name ?? "").isEmpty ? "" : (self.dataProject?.province_name ?? "").isEmpty ? "" : ", "
        }
    }
}

struct HouseScroll: View {
    @State var dataSelling: HomeProductSellListModel?
    @State var isLike = false
    @State var commaAddress = ""
    @State var commaDistrict = ""

    var body: some View {
        ZStack (alignment: .topTrailing) {
            Button(action: {

            }) {
                VStack (alignment: .leading, spacing: 0) {
                    ZStack {
                        if (dataSelling?.project_avatar_url ?? "").isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: dataSelling?.project_avatar_url ?? ""))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: W(175), height: H(127))
                        .clipped().cornerRadius(7)
                        .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                        .padding(.bottom, H(12))
                    TextCustom(text: dataSelling?.project_name ?? "", font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                        .padding(.bottom, H(3))
                        .frame(width: W(165), alignment: .leading)
                    TextCustom(text: "\(dataSelling?.address ?? "")\(commaAddress)\(dataSelling?.district_name ?? "")\(commaDistrict)\(dataSelling?.province_name ?? "")", font: LIGHT_ITALIC, size: 10, lineLimit: 1, color: #colorLiteral(red: 0.6705111265, green: 0.6706646085, blue: 0.6661948562, alpha: 1))
                        .padding(.bottom, H(6))
                        .frame(width: W(165), alignment: .leading)
                    ZStack (alignment: .leading) {
                        HStack {
                            ImageCustom(name: "areaWhite", w: 16, h: 16)
                            Spacer()
                        }
                        HStack (spacing: 0) {
                            TextCustom(text: "\(Utils.formatHighNumber(Double(dataSelling?.area_m2_total ?? 0))) m", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                                .padding(.leading, 26)
                            TextCustom(text: "2", font: REGULAR, size: 8, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                                .offset(y: -3)
                        }
                    }.frame(width: W(175))
                        .padding(.bottom, H(7))
                    ZStack (alignment: .leading) {
                        HStack {
                            ImageCustom(name: "Group8932", w: 16, h: 16)
                            Spacer()
                        }
                        TextCustom(text: "\(Utils.formatHighNumber(Double(dataSelling?.estimate_price ?? 0)))", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                            .padding(.leading, 26)
                            .frame(width: W(165), alignment: .leading)
                    }.frame(width: W(175))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
            Button(action: {
                self.isLike.toggle()
            }) {
                ImageCustom(name: isLike ? "heartPurpleSolid" : "heartPurpleLine", w: 30, h: 30)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                .padding(.top, 9)
                .padding(.trailing, 9)
        }.onAppear {
            self.commaAddress = (self.dataSelling?.address ?? "").isEmpty ? "" : (self.dataSelling?.district_name ?? "").isEmpty && (self.dataSelling?.province_name ?? "").isEmpty ? "" : ", "
            self.commaDistrict = (self.dataSelling?.district_name ?? "").isEmpty ? "" : (self.dataSelling?.province_name ?? "").isEmpty ? "" : ", "
        }
    }
}

struct DiscoverData: Hashable {
    var index: Int
    var imageName: String
    var label: String
    var projectAmount: Int
}

struct ProjectListData: Identifiable, Hashable {
    var id = UUID()
    var index: Int
    var imageName: String
    var label: String
    var type: String
    var location: String
    var period: String
    var isStart: Bool
}

struct HouseData: Identifiable, Hashable {
    var id = UUID()
    var index: Int
    var imageName: String
    var label: String
    var type: String
    var location: String
    var period: String
    var isLike: Bool
    var isNew: Bool
}

func convertToArrDataForMap (data: [HomeProjectListModel]) -> [DataForMap] {
    var dataForMap: [DataForMap] = []

    for item in data {
        let commaAddress = (item.address ?? "").isEmpty ? "" : (item.district_name ?? "").isEmpty && (item.province_name ?? "").isEmpty ? "" : ", "
        let commaDistrict = (item.district_name ?? "").isEmpty ? "" : (item.province_name ?? "").isEmpty ? "" : ", "

        dataForMap.append(DataForMap(
            id: item.id,
            title: item.project_name ?? "",
            location: CLLocationCoordinate2D(latitude: item.latitude ?? 0, longitude: item.longitude ?? 0),
            projectId: item.project_id ?? 0,
            stringName: item.project_name ?? "",
            stringAddress: "\((item.address ?? ""))\(commaAddress)\((item.district_name ?? ""))\(commaDistrict)\((item.province_name ?? ""))",
            isProjectNear: false,
            icon: ""))
    }
    //appen to test
    dataForMap.append(DataForMap(title: "Dự án VTP", location: CLLocationCoordinate2D(latitude: 10.806636, longitude: 106.553135), projectId: 0, stringName: "stringName", stringAddress: "stringAddress", isProjectNear: false, icon: ""))
    return dataForMap
}
func convertToDataForMap (data: HomeProjectListModel) -> DataForMap {
    let dataForMap: DataForMap = DataForMap(
        id: data.id,
        title: data.project_name ?? "",
        location: CLLocationCoordinate2D(latitude: data.latitude ?? 0, longitude: data.longitude ?? 0),
        projectId: data.project_id ?? 0,
        stringName: data.project_name ?? "",
        stringAddress: (data.address ?? "") + (data.district_name ?? "") + (data.province_name ?? ""),
        isProjectNear: false,
        icon: "")
    return dataForMap
}
