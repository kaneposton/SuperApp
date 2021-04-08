// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import SwiftUI
import Mapbox
import RxSwift
import SDWebImageSwiftUI
import Combine

// MARK: TEMP
import MapKit

struct MapView: View {
    let closeSideMenu: () -> Void
    @Binding var projectName: String
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int

    // MAPBOX
    @State var isUserTracking = false
    var localDataMap: [DataForMap]

    var tapped: ((Int) -> Void)? = { _ in }
    var data: [DataForMap] = []
    @State var coorDinate: DataForMap
    @State var arrCoorDinate: [CLLocationCoordinate2D] = []
    @State var isSearch = false
    var viewWillAppear: ((Int) -> Void)? = { _ in }
    @State var userTracking = false
    @State var index = 1
    @State var indexLocal = 1
    @State var isViewSaleMarketing = true

    @State var zoomLevel: Double = 13
    var maximumZoomLevel: Double = MGLMapView(frame: .zero, styleURL: URL(string: "https://images.vietbando.com/Style/vt_vbddefault/bbb9c9ad-00b9-4066-bc88-06b401b8eddd")).maximumZoomLevel
    var minumumZoomLevel: Double = MGLMapView(frame: .zero, styleURL: URL(string: "https://images.vietbando.com/Style/vt_vbddefault/bbb9c9ad-00b9-4066-bc88-06b401b8eddd")).minimumZoomLevel
    @State var countLocation = 0

    @State var isTapFilter = false
    @State var strSearch = ""

    @State var project_id = -1

    @State var listData = [HomeProjectListModel]()
    @State var selectedProject = 0
    @State var selectedNameProject = ""
    @State var selectedProjectTagID = -1
    @State var isConfirmProject = false
    @State var isScrollAppear = false
    @State var isTagAppear = false
    @State var isNextFilter = false
    @State var isFilter = false
    @State var currentWidthTag: CGFloat = 0
    @State var isOverWidth = false
    @State var isNextProjectHome = false
    @ObservedObject var homeViewModel = HomeViewModel()

    // MARK: FILTER MAP ========================================
    // MARK: TÌNH TRẠNG
    @State var selectedStatusMap = [
        typeStatusFilter(id: 0, name: "Đang bán", enable: false, index: 0),
        typeStatusFilter(id: 1, name: "Sắp bán", enable: false, index: 1)
    ]

    // MARK: DỰ ÁN
    @State var selectedProjectMap = [typeProjectFilter(id: 0, name: "", enable: false, index: 0)]
    @State var setting_typeMap = [0]

    // MARK: LOẠI HÌNH DỰ ÁN
    @State var selectedTypeMap = [false, false, false]

    // MARK: TỈNH/ THÀNH PHỐ
    @State var selectedCityMap: [String] = []
    @State var selectedProvinceMap: [Int] = []

    // MARK: QUẬN/ HUYỆN
    @State var selectedDistrictMap: [String] = []
    @State var selectedDistrictIDMap: [Int] = []
    // ========================================

    @State var isDataNotOriginal = false
    @State var project_status: [Int] = []
    @State var disposables = Set<AnyCancellable>()
    @State var isHasData = false
    @State var dataTag = HomeProjectListModel(project_id: 0, project_name: "", project_status: 0, address: "", total_area_square: 0, latitude: 0, longitude: 0, date_opened: "", rank_type: 0, description: "", project_avatar_url: "", province_id: 0, province_name: "", district_id: 0, district_name: "", location: HomeProjectLocationModel(type: "", coordinates: [[[0]]]), project_highlights: false, project_setting_type: [HomeProjectSettingTypeModel(name: "", type_id: 0)], is_sell: false, sale_open_name: "")
    @State var isHaveDataTag = false
    @State var selectedSelling = false
    @State var projectURL = ""

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                // MARK: KHI SEARCH VÀ CHỌN KẾT QUẢ SẼ HIỂN THỊ THẺ TRONG KHUNG SEARCH
                if selectedProjectTagID != -1 {
                    Text("").onAppear {
                        for i in 0 ..< self.listData.count {
                            if (self.selectedProjectTagID == self.listData[i].project_id)
                                && self.selectedSelling == self.listData[i].is_sell {
                                self.dataTag = self.listData[i]
                                self.isHaveDataTag = true
                                self.isSearch = true
                            }
                        }
                    }
                } else { // MARK: NGƯỢC LẠI SẼ XOÁ THẺ
                    Text("").onAppear {
                        self.isHaveDataTag = false
                        self.isSearch = false
                    }
                }

                // MARK: KHI BẤM CHỨC NĂNG LỌC THÌ SẼ XOÁ TOÀN BỘ NỘI DUNG TRONG Ô SEARCH
                if isTapFilter {
                    Text("").onAppear {
                        self.isTagAppear = false
                        self.isConfirmProject = false
                        self.selectedNameProject = ""
                        self.selectedProjectTagID = -1
                        self.strSearch = ""
                        self.isOverWidth = false
                        self.isTapFilter = false
                    }
                }

                // MARK: NẾU SANG MÀN HÌNH KHÁC THÌ ĐÓNG BẢN ĐỒ LẠI - PERFORMANCE
                if !isNextFilter {
                    mapBox(
                        isFilter: self.isFilter,
                        data: self.localDataMap,
                        coorDinate: self.$coorDinate,
                        arrCoorDinate: self.$arrCoorDinate,
                        viewWillAppear: { _ in },
                        userTracking: self.$userTracking,
                        zoomLevel: self.coorDinate.location.latitude == 0 && self.coorDinate.location.longitude == 0 ? Binding.constant(0):
                            self.$zoomLevel
                    ).edgesIgnoringSafeArea(.all)
                }
                ZStack (alignment: .top) {
                    // MARK: TEMP UI ==================================================
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: H(isScrollAppear ? 200 : 44))
                        .background(Color.white)
                        .cornerRadius(7)
                        .padding(.horizontal, 16)
                        .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 3, x: 1, y: 3)
                    // MARK: ==========================================================
                    ZStack (alignment: .leading) {
                        ImageCustom(name: "searchBlue", w: 18, h: 18)
                            .padding(.horizontal, W(16))
                        ZStack (alignment: .leading) {
                            TextCustom(text: selectedProjectTagID == -1 ? NSLocalizedString("map_search", comment: "") : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117647059, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                .fixedSize(horizontal: true, vertical: false)
                                .opacity(strSearch.isEmpty ? 1 : 0)
                            TextField("", text: $strSearch)
                                .font(.custom(REGULAR, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                .padding(.trailing, 76)
                                .frame(height: H(14))
                            if isConfirmProject && keyboardHeight <= 0 {
                                HStack (spacing: W(12)) {
                                    TextCustom(text: "\(selectedNameProject) (\(NSLocalizedString(selectedSelling ? "search_isSell" : "search_isSellSoon", comment: "")))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                        .frame(width: isOverWidth ? currentWidthTag : nil)
                                        .fixedSize (horizontal: isOverWidth ? false : true, vertical: false)
                                    Button(action: {
                                        self.PopSearchResult()
                                        self.isOverWidth = false
                                    }) {
                                        ImageCustom(name: "deleteAllPurple", w: 13.7, h: 13.7)
                                    }.buttonStyle(ButtonTapScale())
                                        .animation(.easeInOut(duration: 0.1))
                                }.padding(.horizontal, W(16))
                                    .frame(height: H(30))
                                    .background(
                                        GeometryReader { geometry in
                                            Color.init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)).onAppear {
                                                if geometry.size.width > FULL_W - 144 {
                                                    self.currentWidthTag = FULL_W - 205
                                                    self.isOverWidth = true
                                                } else {
                                                    self.currentWidthTag = 0
                                                    self.isOverWidth = false
                                                }
                                            }
                                        }
                                    ).cornerRadius(5)
                                    .onAppear {
                                        self.isTagAppear = true
                                    }.onDisappear {
                                        self.isTagAppear = false
                                    }.onTapGesture {
                                        self.isConfirmProject = false
                                }
                            }
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.strSearch = ""
                                    self.selectedProjectTagID = -1
                                    self.selectedNameProject = ""
                                    self.isConfirmProject = false
                                }) {
                                    ZStack (alignment: .trailing) {
                                        ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                        ImageCustom(name: "deleteAll", w: 14, h: 14)
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                    .offset(x: W(-3.5))
                                    .opacity(keyboardHeight > 0 && !strSearch.isEmpty ? 1 : !isConfirmProject && !strSearch.isEmpty ? 1 : 0)
                            }.padding(.trailing, 57)
                        }.padding(.leading, W(49.7))
                        HStack (spacing: 15) {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.init(#colorLiteral(red: 0.8407533765, green: 0.827776432, blue: 0.8273850083, alpha: 1)))
                                .frame(width: 1, height: H(34))
                            Button(action: {
                                self.isNextFilter = true
                                self.isDataNotOriginal = true
                                UIApplication.shared.endEditing()
                            }) {
                                ImageCustom(name: isFilter ? "filterPurple" : "filterBlue", w: 16, h: 14)
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }.padding(.trailing, 15)
                    }.frame(height: H(44))
                        .background(Color.white)
                        .cornerRadius(7)
                        .padding(.horizontal, 16)
                    if !isTagAppear {
                        if listData.firstIndex(where: ({ ($0.project_name ?? "").localizedStandardContains(strSearch) })) != nil {
                            ScrollView (showsIndicators: false) {
                                VStack (alignment: .leading, spacing: 0) {
                                    Rectangle()
                                        .frame(height: H(1))
                                        .foregroundColor(.init(#colorLiteral(red: 0.8486694694, green: 0.8487718701, blue: 0.8486347198, alpha: 1)))
                                    ForEach(listData.filter { return ($0.project_name ?? "").localizedStandardContains(strSearch) }, id: \.self) { item in

                                        VStack (alignment: .leading, spacing: 0) {
                                            Button(action: {
                                                self.AppendSearchResult(projectName: item.project_name ?? "", projectID: item.project_id ?? 0, projectIsSell: item.is_sell ?? false)
                                            }) {
                                                TextCustom(text: "\(item.project_name ?? "") (\(NSLocalizedString(item.is_sell ?? false ? "search_isSell" : "search_isSellSoon", comment: "")))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.2684262395, green: 0.2684628665, blue: 0.2684137821, alpha: 1))
                                            }.buttonStyle(ButtonTapScale())
                                                .padding(.vertical, H(14))
                                            Rectangle()
                                                .frame(height: H(1))
                                                .foregroundColor(.init(#colorLiteral(red: 0.8486694694, green: 0.8487718701, blue: 0.8486347198, alpha: 1)))
                                        }
                                    }
                                }.padding(.bottom, H(44) - 1)
                                    .padding(.horizontal, W(21))
                                    .frame(width: FULL_W - 32, alignment: .leading)
                                    .background(Color.white)
                                    .cornerRadius(7, corners: [.bottomLeft, .bottomRight])

                            }.onAppear {
                                self.isScrollAppear = true
                            }.onDisappear {
                                self.isScrollAppear = false
                            }.frame(height: H(200))
                                .offset(y: H(44) - 1)
                                .cornerRadius(7, corners: [.bottomLeft, .bottomRight])
                        }
                    }
                }.padding(.top, 16)
                VStack (alignment: .trailing, spacing: 0) {
                    Spacer()
                    ZStack {
                        ZStack (alignment: .top) {
                            Rectangle()
                                .frame(height: H(199 + 7) + 23)
                                .foregroundColor(.white)
                                .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 3, y: -3)
                            Rectangle()
                                .frame(height: H(199 + 7) + 23)
                                .foregroundColor(.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                .offset(y: H(199 + 7) + 23)
                            if isFilter || isDataNotOriginal {
                                if isHasData {
                                    if isHaveDataTag {
                                        MapDataContent(
                                            projectURL: $projectURL,
                                            project_id: $project_id,
                                            projectName: $projectName,
                                            isNextProjectHome: $isNextProjectHome,
                                            data: dataTag,
                                            coorDinate: $coorDinate,
                                            arrCoorDinate: $arrCoorDinate,
                                            zoomLevel: $zoomLevel
                                        ).background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                    } else {
                                        if listData.count == 1 {
                                            MapDataContent(
                                                projectURL: $projectURL,
                                                project_id: $project_id,
                                                projectName: $projectName,
                                                isNextProjectHome: $isNextProjectHome,
                                                data: listData[0],
                                                coorDinate: self.$coorDinate,
                                                arrCoorDinate: self.$arrCoorDinate,
                                                zoomLevel: self.$zoomLevel
                                            ).background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                        }
                                        if listData.count > 1 {
                                            ScrollView (.horizontal, showsIndicators: false) {
                                                ZStack (alignment: .topLeading) {
                                                    HStack (spacing: 16) {
                                                        ForEach(listData.enumeratedArray(), id: \.element) { index, data in
                                                            MapProjectScroll(
                                                                projectURL: self.$projectURL,
                                                                project_id: self.$project_id,
                                                                projectName: self.$projectName,
                                                                isNextProjectHome: self.$isNextProjectHome,
                                                                selectedProject: self.$selectedProject,
                                                                coorDinate: self.$coorDinate,
                                                                arrCoorDinate: self.$arrCoorDinate,
                                                                zoomLevel: self.$zoomLevel,
                                                                data: data,
                                                                index: index
                                                            )
                                                        }
                                                    }
                                                    Rectangle()
                                                        .frame(width: W(220), height: H(3))
                                                        .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                                        .cornerRadius(.infinity)
                                                        .offset(x: CGFloat(selectedProject) * (W(220) + 16), y: -11.5)
                                                        .animation(.easeInOut(duration: 0.2))
                                                }.frame(height: H(199 + 7) + 23, alignment: .bottom)
                                                    .padding(.horizontal, 16)
                                                    .padding(.bottom, FULL_H == 736 || FULL_H <= 667 ? H(16) : 0)
                                            }.background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                        }
                                    }
                                }
                            } else {
                                if isHaveDataTag {
                                    MapDataContent(
                                        projectURL: $projectURL,
                                        project_id: $project_id,
                                        projectName: $projectName,
                                        isNextProjectHome: $isNextProjectHome,
                                        data: dataTag,
                                        coorDinate: $coorDinate,
                                        arrCoorDinate: $arrCoorDinate,
                                        zoomLevel: $zoomLevel
                                    ).background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                } else {
                                    if listData.count == 1 {
                                        MapDataContent(
                                            projectURL: $projectURL,
                                            project_id: $project_id,
                                            projectName: $projectName,
                                            isNextProjectHome: $isNextProjectHome,
                                            data: listData[0],
                                            coorDinate: $coorDinate,
                                            arrCoorDinate: $arrCoorDinate,
                                            zoomLevel: $zoomLevel
                                        ).background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                    }
                                    if listData.count > 1 {
                                        ScrollView (.horizontal, showsIndicators: false) {
                                            ZStack (alignment: .topLeading) {
                                                HStack (spacing: 16) {
                                                    ForEach(listData.enumeratedArray(), id: \.element) { index, data in
                                                        MapProjectScroll(
                                                            projectURL: self.$projectURL,
                                                            project_id: self.$project_id,
                                                            projectName: self.$projectName,
                                                            isNextProjectHome: self.$isNextProjectHome,
                                                            selectedProject: self.$selectedProject,
                                                            coorDinate: self.$coorDinate,
                                                            arrCoorDinate: self.$arrCoorDinate,
                                                            zoomLevel: self.$zoomLevel,
                                                            data: data,
                                                            index: index
                                                        )
                                                    }
                                                }
                                                Rectangle()
                                                    .frame(width: W(220), height: H(3))
                                                    .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                                    .cornerRadius(.infinity)
                                                    .offset(x: CGFloat(selectedProject) * (W(220) + 16), y: -11.5)
                                                    .animation(.easeInOut(duration: 0.2))
                                            }.frame(height: H(199 + 7) + 23, alignment: .bottom)
                                                .padding(.horizontal, 16)
                                                .padding(.bottom, FULL_H == 736 || FULL_H <= 667 ? H(16) : 0)
                                        }.background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                                    }
                                }
                            }
                        }
                        if isFilter || isDataNotOriginal {
                            if isHasData {
                                if listData.count == 0 {
                                    ImageCustom(name: "NoResult", w: 219, h: 150)
                                }
                            }
                        } else {
                            if listData.count == 0 {
                                ImageCustom(name: "NoResult", w: 219, h: 150)
                            }
                        }
                    }
                }
                VStack (alignment: .trailing, spacing: 0) {
                    Spacer()
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: W(44), height: W(78))
                            .cornerRadius(9)
                            .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 5)
                        VStack {
                            Button(action: {
                                if self.zoomLevel > self.minumumZoomLevel {
                                    self.zoomLevel -= 1
                                } else {
                                    self.zoomLevel = self.minumumZoomLevel
                                }
                            }) {
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 44, h: 39)
                                    ImageCustom(name: "minus", w: 14, h: 2)
                                }.background(Color.white)
                                    .cornerRadius(9)
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                            Spacer()
                        }.frame(height: W(78))
                        VStack {
                            Spacer()
                            Button(action: {
                                if self.zoomLevel < self.maximumZoomLevel {
                                    self.zoomLevel += 1
                                } else {
                                    self.zoomLevel = self.maximumZoomLevel
                                }
                            }) {
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 44, h: 39)
                                    ImageCustom(name: "plus", w: 14, h: 14)
                                        .disabled(zoomLevel == maximumZoomLevel ? true : false)
                                }.frame(width: W(44), height: W(39))
                                    .background(Color.white)
                                    .cornerRadius(9)
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }.frame(height: W(78))
                        Rectangle()
                            .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                            .frame(width: W(19.5), height: 1)
                    }.padding(.trailing, 16)
                        .padding(.bottom, 24)
                    HStack {
                        Button(action: {
                            self.isNextOld = false
                            self.isDataNotOriginal = false
                            UIApplication.shared.endEditing()
                        }) {
                            ZStack {
                                Rectangle().foregroundColor(.white)
                                    .frame(width: W(44), height: W(44))
                                    .cornerRadius(.infinity)
                                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 5)
                                ImageCustom(name: "arrowBackMap", w: 17.6, h: 16.1)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                        Button(action: {
                            self.userTracking = true
                        }) {
                            ImageCustom(name: "my_location", w: 44, h: 44)
                                .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 5)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                    }.padding(.horizontal, 16)
                        .padding(.bottom,
                            FULL_H == H_SE && FULL_W == W_SE ? 25: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 28: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 28: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 16: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 16 : 0) // iPhone 11 Pro
                }.padding(.bottom, H(199 + 7) + 23)
                NavigationLink(destination:
                        SearchFilterView(
                            // MARK: MAP
                            isTapFilter: $isTapFilter,
                            // MARK: TEMP
                            closeSideMenu: { },
                            isOpenSideMenu: Binding.constant(false),
                            isSideMenuAppear: Binding.constant(false),
                            isNextSideMenu: Binding.constant(false),
                            selectedMenuPurple: Binding.constant(0),
                            selectedCorlor: Binding.constant(0),
                            // ================
                            isNextOld: $isNextFilter,
                            isFilter: $isFilter,
                            isFromMap: true,
                            selectedStatusMap: $selectedStatusMap,
                            selectedCityMap: $selectedCityMap,
                            selectedProvinceMap: $selectedProvinceMap,
                            selectedDistrictMap: $selectedDistrictMap,
                            selectedDistrictIDMap: $selectedDistrictIDMap
                        ), isActive: $isNextFilter) {
                    EmptyView()
                }
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
            }.resignKeyboardOnDragGesture()
                .keyboardAppear(keyboardHeight: $keyboardHeight)
                .onAppear {
                    self.project_status = []
                    for i in 0 ..< self.selectedStatusMap.count {
                        if self.selectedStatusMap[i].enable {
                            self.project_status.append(self.selectedStatusMap[i].id)
                        }
                    }
                    if self.isFilter {
                        self.isHasData = false
                        self.homeViewModel.fetchDataProjectList(
                            settingType: [0],
                            provinceId: self.selectedProvinceMap,
                            projectStatus: self.project_status,
                            language: VIETNAM,
                            districtId: self.selectedDistrictIDMap
                        )
                        self.homeViewModel.vldFilterProjectList.sink { rs in
                            self.listData = self.homeViewModel.homeProjectList ?? []
                            self.isHasData = true
                        }.store(in: &self.disposables)
                    } else {
                        if self.isDataNotOriginal {
                            self.isHasData = false

                            self.homeViewModel.fetchDataProjectList(
                                settingType: [0],
                                provinceId: [],
                                projectStatus: [0, 1],
                                language: VIETNAM,
                                districtId: []
                            )

                            self.homeViewModel.vldFilterProjectList.sink { rs in
                                self.listData = self.homeViewModel.homeProjectList ?? []
                                self.isHasData = true
                            }.store(in: &self.disposables)
                        }
                    }
                    //MARK: GET LOCATION INIT OF MAP
                    self.arrCoorDinate.removeAll()
                    self.countLocation = 0
                    if self.listData.count != 0
                        {
                        for item1 in (self.listData[0].location ?? HomeProjectLocationModel(type: "", coordinates: [[[0]]])).coordinates ?? [] {
                            if self.countLocation == 0 {
                                for item2 in item1 { self.arrCoorDinate.append(CLLocationCoordinate2D(latitude: item2[1], longitude: item2[0]))
                                }
                            }
                            self.countLocation += 1
                        }
                    }
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }

    func AppendSearchResult(projectName: String, projectID: Int, projectIsSell: Bool) {
        selectedNameProject = projectName
        selectedProjectTagID = projectID
        selectedSelling = projectIsSell
        strSearch = projectName
        isConfirmProject = true
        UIApplication.shared.endEditing()
    }

    func PopSearchResult() {
        selectedNameProject = ""
        selectedProjectTagID = -1
        strSearch = ""
        isConfirmProject = false
    }
}

struct MapProjectScroll: View {
    @Binding var projectURL: String
    @Binding var project_id: Int
    @Binding var projectName: String
    @Binding var isNextProjectHome: Bool
    @Binding var selectedProject: Int
    @Binding var coorDinate: DataForMap
    @Binding var arrCoorDinate: [CLLocationCoordinate2D]
    @Binding var zoomLevel: Double

    @State var data = HomeProjectListModel()
    @State var index = 0
    @State var countLocation = 0
    @State var commaDistrict = ""

    var body: some View {
        Button(action: {
            if self.selectedProject == self.index {
                self.project_id = self.data.project_id ?? 0
                self.isNextProjectHome = true
                self.projectURL = self.data.project_avatar_url ?? ""
                self.projectName = self.data.project_name ?? ""
                UIApplication.shared.endEditing()
            } else {
                self.selectedProject = self.index
                self.coorDinate.location.latitude = self.data.latitude ?? 0
                self.coorDinate.location.longitude = self.data.longitude ?? 0
                self.arrCoorDinate.removeAll()
                self.countLocation = 0
                for item1 in (self.data.location ?? HomeProjectLocationModel(type: "", coordinates: [[[0]]])).coordinates ?? [] {
                    if self.countLocation == 0 {
                        for item2 in item1 {
                            self.arrCoorDinate.append(CLLocationCoordinate2D(latitude: item2[1], longitude: item2[0]))
                        }
                    }
                    self.countLocation += 1
                }
                self.zoomLevel = 13
            }
        }) {
            VStack (alignment: .leading, spacing: 0) {
                ZStack (alignment: .topLeading) {
                    ZStack {
                        if (data.project_avatar_url ?? "").isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: data.project_avatar_url ?? ""))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: W(220), height: H(127))
                        .clipped()
                        .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                    ZStack (alignment: .leading) {
                        ImageCustom(name: data.is_sell ?? false ? "greenHomeFlag" : "orangeHomeFlag", w: 74, h: 24)
                            .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921)), radius: 2, y: 2)
                        TextCustom(text: NSLocalizedString(data.is_sell ?? false ? "search_isSell" : "search_isSellSoon", comment: ""), font: REGULAR, size: 11, color: .white)
                            .padding(.leading, 8.5)
                    }.padding(.top, 10)
                }.cornerRadius(7)
                    .shadow(color: .init(#colorLiteral(red: 0.6814993087, green: 0.6814993087, blue: 0.6814993087, alpha: 1)), radius: 4)
                    .padding(.bottom, H(12))
                TextCustom(text: data.project_name ?? "", font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    .padding(.bottom, H(7))
                    .frame(width: W(210), alignment: .leading)
                ZStack (alignment: .leading) {
                    HStack {
                        ImageCustom(name: "locationBlue", w: 14, h: 14)
                        Spacer()
                    }
                    TextCustom(text: "\(data.district_name ?? "")\(commaDistrict)\(data.province_name ?? "")", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        .padding(.leading, 20)
                        .frame(width: W(210), alignment: .leading)
                }.frame(width: W(220))
                    .padding(.bottom, H(7))
                ZStack (alignment: .leading) {
                    HStack {
                        ImageCustom(name: "timeBlue", w: 16, h: 16)
                        Spacer()
                    }
                    TextCustom(text: "\(data.sale_open_name ?? ""): \((data.date_opened ?? "").formatDate(from: "yyyy-MM-dd", to: "dd/MM/yyyy"))", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                        .padding(.leading, 20)
                        .frame(width: W(210), alignment: .leading)
                }.frame(width: W(220))
            }.background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                .onAppear {
                    //get location
                    if self.selectedProject == self.index {
                        self.coorDinate = DataForMap(
                            id: self.data.id,
                            title: self.data.project_name ?? "",
                            location: CLLocationCoordinate2D(latitude: self.data.latitude ?? 0, longitude: self.data.longitude ?? 0),
                            projectId: self.data.project_id ?? 0,
                            stringName: self.data.project_name ?? "",
                            stringAddress: (self.data.address ?? "") + (self.data.district_name ?? "") + (self.data.province_name ?? ""),
                            isProjectNear: false,
                            icon: "")
                        self.arrCoorDinate.removeAll()
                        self.countLocation = 0
                        for item1 in (self.data.location ?? HomeProjectLocationModel(type: "", coordinates: [[[0]]])).coordinates ?? [] {
                            if self.countLocation == 0 {
                                for item2 in item1 {
                                    self.arrCoorDinate.append(CLLocationCoordinate2D(latitude: item2[1], longitude: item2[0]))
                                }
                            }
                            self.countLocation += 1
                        }
                        self.zoomLevel = 13
                    }
            }
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
            .onAppear {
                self.commaDistrict = (self.data.district_name ?? "").isEmpty ? "" : (self.data.province_name ?? "").isEmpty ? "" : ", "
        }
    }
}

struct MapDataContent: View {
    @Binding var projectURL: String
    @Binding var project_id: Int
    @Binding var projectName: String
    @Binding var isNextProjectHome: Bool
    @State var data = HomeProjectListModel()
    @Binding var coorDinate: DataForMap
    @Binding var arrCoorDinate: [CLLocationCoordinate2D]
    @Binding var zoomLevel: Double
    @State var countLocation = 0
    @State var commaAddress = ""
    @State var commaDistrict = ""

    var body: some View {
        Button(action: {
            self.project_id = self.data.project_id ?? 0
            self.projectURL = self.data.project_avatar_url ?? ""
            self.projectName = self.data.project_name ?? ""
            self.isNextProjectHome = true
            UIApplication.shared.endEditing()
        }) {
            VStack (alignment: .leading, spacing: 0) {
                ZStack(alignment: .topLeading) {
                    ZStack {
                        if (data.project_avatar_url ?? "").isEmpty {
                            Image("default_medium")
                                .resizable()
                        } else {
                            ZStack {
                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                WebImage(url: URL(string: data.project_avatar_url ?? ""))
                                    .resizable()
                            }
                        }
                    }.scaledToFill()
                        .frame(width: FULL_W, height: H(199 + 7 - 48) + 23 - (FULL_H == 736 || FULL_H <= 667 ? H(16) : 0))
                        .clipped()
                    ZStack (alignment: .leading) {
                        ImageCustom(name: data.is_sell ?? false ? "greenHomeFlag" : "orangeHomeFlag", w: 74, h: 24)
                            .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.4252193921)), radius: 2, y: 2)
                        TextCustom(text: NSLocalizedString(data.is_sell ?? false ? "search_isSell" : "search_isSellSoon", comment: ""), font: REGULAR, size: 11, color: .white)
                            .padding(.leading, 8.5)
                    }.padding(.top, 10)
                }
                TextCustom(text: data.project_name ?? "", font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .frame(width: FULL_W - 34, alignment: .leading)
                    .padding(.leading, 17)
                    .padding(.top, H(10))
                    .padding(.bottom, H(7))
                HStack(spacing: 6) {
                    ImageCustom(name: "locationBlue", w: 14, h: 14)
                    TextCustom(text: "\(data.address ?? "")\(commaAddress)\(data.district_name ?? "")\(commaDistrict)\(data.province_name ?? "")", font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.2509803922, green: 0.2941176471, blue: 0.4117647059, alpha: 1))
                        .fixedSize(horizontal: true, vertical: false)
                }.padding(.horizontal, 17)
            }.frame(height: H(199 + 7) + 23, alignment: .top)
                .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
        }.buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.1))
            .padding(.bottom, FULL_H == 736 || FULL_H <= 667 ? H(16) : 0)
            .onAppear {
                self.commaAddress = (self.data.address ?? "").isEmpty ? "" : (self.data.district_name ?? "").isEmpty && (self.data.province_name ?? "").isEmpty ? "" : ", "
                self.commaDistrict = (self.data.district_name ?? "").isEmpty ? "" : (self.data.province_name ?? "").isEmpty ? "" : ", "

                //get location
                self.coorDinate = DataForMap(
                    id: self.data.id,
                    title: self.data.project_name ?? "",
                    location: CLLocationCoordinate2D(latitude: self.data.latitude ?? 0, longitude: self.data.longitude ?? 0),
                    projectId: self.data.project_id ?? 0,
                    stringName: self.data.project_name ?? "",
                    stringAddress: (self.data.address ?? "") + (self.data.district_name ?? "") + (self.data.province_name ?? ""),
                    isProjectNear: false,
                    icon: "")
                self.arrCoorDinate.removeAll()
                self.countLocation = 0
                for item1 in (self.data.location ?? HomeProjectLocationModel(type: "", coordinates: [[[0]]])).coordinates ?? [] {
                    if self.countLocation == 0 {
                        for item2 in item1 {
                            self.arrCoorDinate.append(CLLocationCoordinate2D(latitude: item2[1], longitude: item2[0]))
                        }
                    }
                    self.countLocation += 1
                }
                self.zoomLevel = 13
        }
    }
}

struct MapViewTemp: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<MapViewTemp>) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapViewTemp>) {
        let location = CLLocationCoordinate2D(
            latitude: 20.9988123195566,
            longitude: 105.699449882885
        )

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        uiView.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = "Hà Nội"
        annotation.subtitle = "London"
        uiView.addAnnotation(annotation)
    }
}
