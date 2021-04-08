// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import RxSwift
import Combine

struct typeStatusFilter: Identifiable, Hashable {
    var uuid = UUID()
    var id: Int
    var name: String
    var enable: Bool
    var index: Int
}

struct typeProjectFilter: Identifiable, Hashable {
    var uuid = UUID()
    var id: Int
    var name: String
    var enable: Bool
    var index: Int
}
struct SearchFilterView: View {
    // MARK: MAP
    @Binding var isTapFilter: Bool

    let closeSideMenu: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @Binding var isNextOld: Bool
    @Binding var isFilter: Bool
    @State var isFromMap = false
    @State var isFromDiscover = false

    // MARK: FILTER MAP ========================================
    // MARK: TÌNH TRẠNG
    @Binding var selectedStatusMap: [typeStatusFilter]

    // MARK: TỈNH/ THÀNH PHỐ
    @Binding var selectedCityMap: [String]
    @Binding var selectedProvinceMap: [Int]

    // MARK: QUẬN/ HUYỆN
    @Binding var selectedDistrictMap: [String]
    @Binding var selectedDistrictIDMap: [Int]
    // ========================================

    // MARK: FILTER PROJECT ========================================
    // MARK: TÌNH TRẠNG
    @State var selectedStatus = [
        typeStatusFilter(id: 0, name: "Đang bán", enable: false, index: 0),
        typeStatusFilter(id: 1, name: "Sắp bán", enable: false, index: 1)
    ]

    // MARK: DỰ ÁN
    @State var selectedProject = [typeProjectFilter(id: 0, name: "Tất cả", enable: true, index: 0)] //  [true, false, false, false, false, false]
    @State var setting_type = [0]

    // MARK: TỈNH/ THÀNH PHỐ
    @State var selectedCity: [String] = []
    @State var selectedProvince: [Int] = []

    // MARK: QUẬN/ HUYỆN
    @State var selectedDistrict: [String] = []
    @State var selectedDistrictID: [Int] = []
    // ========================================

    // MARK: TEMP VARIABLE ========================================
    // MARK: TÌNH TRẠNG
    @State var temp_selectedStatus = [
        typeStatusFilter(id: 0, name: "Đang bán", enable: false, index: 0),
        typeStatusFilter(id: 1, name: "Sắp bán", enable: false, index: 1)
    ]

    // MARK: DỰ ÁN
    @State var temp_selectedProject = [typeProjectFilter(id: 0, name: "Tất cả", enable: true, index: 0)] //  [true, false, false, false, false, false]
    @State var temp_setting_type = [0]

    // MARK: TỈNH/ THÀNH PHỐ
    @State var temp_selectedCity: [String] = []
    @State var temp_selectedProvince: [Int] = []

    // MARK: QUẬN/ HUYỆN
    @State var temp_selectedDistrict: [String] = []
    @State var temp_selectedDistrictID: [Int] = []
    // ============================================================

    @State var strSearchCity = ""
    @State var strSearchDistrict = ""
    @State var isFromFilter = false
    @State var isNext = false
    @State var isAddProvince = false
    @State var disposables = Set<AnyCancellable>()
    @State var isHasDataStatus = false
    @State var isHasDataProject = false
    @State var dataLocalStatus = [
        FilterStatusListModel(id: 0, name: "Đang bán"),
        FilterStatusListModel(id: 1, name: "Sắp bán")
    ]
    @State var dataLocalProject = [FilterProjectListModel]()
    @State var dataLocalCity = [FilterCityListModel]()
    @State var dataLocalDistrict = [FilterDistrictListModel]()
    @State var project_status: [Int] = []
    @State var isTapTextFieldDistrict = false

    @ObservedObject var filterViewModel = FilterViewModel()

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                if isAddProvince && self.temp_selectedProvince.count == 1 {
                    Text("").onAppear {
                        self.filterViewModel.fetchDataFilterDistrict(province_id: self.temp_selectedProvince[0])
                        self.filterViewModel.vldFilterDistrictList.sink { rs in
                            self.dataLocalDistrict = self.filterViewModel.filterDistrictList ?? []
                            self.isAddProvince = false
                        }.store(in: &self.disposables)
                    }
                }
                VStack (alignment: .leading, spacing: 0) {
                    HStack (spacing: 12) {
                        Button(action: {
                            UITableView.appearance().isScrollEnabled = true
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                        }) {
                            HStack (spacing: 12) {
                                ImageCustom(name: "closeBlack18", w: 18, h: 18)
                                    .offset(y: 1)
                                TextCustom(text: NSLocalizedString("filter_filter", comment: ""), size: 24, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                        Button(action: {
                            // MARK: TÌNH TRẠNG
                            for i in 0 ..< self.temp_selectedStatus.count {
                                self.temp_selectedStatus[i].enable = false
                            }

                            // MARK: DỰ ÁN
                            for i in 0 ..< self.temp_selectedProject.count {
                                self.temp_selectedProject[i].enable = false
                            }

                            self.temp_selectedProject[0].enable = true
                            self.temp_setting_type = [0]

                            if !self.isFromDiscover {
                                // MARK: TỈNH/ THÀNH PHỐ
                                self.temp_selectedCity = []
                                self.temp_selectedProvince = []
                            }

                            // MARK: QUẬN/ HUYỆN
                            self.temp_selectedDistrict = []
                            self.temp_selectedDistrictID = []
                        }) {
                            ImageCustom(name: "resetPurple", w: 18, h: 18)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                    }.padding(.horizontal, 20)
                        .padding(.bottom, H(13))
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 0) {
                            TextCustom(text: NSLocalizedString("filter_description", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1))
                                .fixedSize(horizontal: false, vertical: true)
                                .padding(.horizontal, 20)
                                .padding(.bottom, H(24))

                            // MARK: TÌNH TRẠNG
                            FilterStatus(selectedStatus: $temp_selectedStatus, dataLocalStatus: $dataLocalStatus, isHasDataStatus: $isHasDataStatus)

                            if !isFromMap {
                                // MARK: DỰ ÁN
                                FilterProject(
                                    selectedProject: $temp_selectedProject,
                                    setting_type: $temp_setting_type,
                                    dataLocalProject: $dataLocalProject,
                                    isHasDataProject: $isHasDataProject
                                )
                            }

                            if !isFromDiscover {
                                // MARK: TỈNH/ THÀNH PHỐ
                                FilterCity(
                                    selectedCity: $temp_selectedCity,
                                    selectedProvince: $temp_selectedProvince,
                                    strSearch: $strSearchCity,
                                    selectedDistrict: $temp_selectedDistrict,
                                    selectedDistrictID: $temp_selectedDistrictID,
                                    dataLocalCity: $dataLocalCity,
                                    isAddProvince: $isAddProvince
                                )
                            }

                            // MARK: QUẬN/ HUYỆN
                            if isFromDiscover || temp_selectedCity.count == 1 {
                                FilterDistrict(
                                    isTapTextFieldDistrict: $isTapTextFieldDistrict,
                                    selectedDistrict: $temp_selectedDistrict,
                                    selectedDistrictID: $temp_selectedDistrictID,
                                    strSearch: $strSearchDistrict,
                                    dataLocalDistrict: $dataLocalDistrict
                                ).offset(y: isFromDiscover ? 0:
                                        dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearchCity) })) == nil ? 0 : H(44))
                            }

                            Button(action: {
                                UIApplication.shared.endEditing()
                                UITableView.appearance().isScrollEnabled = true
                                if !self.isFromMap {
                                    // MARK: TÌNH TRẠNG
                                    self.selectedStatus = self.temp_selectedStatus
                                    self.project_status = []
                                    for i in 0 ..< self.selectedStatus.count {
                                        if self.selectedStatus[i].enable {
                                            self.project_status.append(self.selectedStatus[i].id)
                                        }
                                    }

                                    // MARK: DỰ ÁN
                                    self.selectedProject = self.temp_selectedProject
                                    self.setting_type = self.temp_setting_type

                                    // MARK: TỈNH/ THÀNH PHỐ
                                    self.selectedCity = self.temp_selectedCity
                                    self.selectedProvince = self.temp_selectedProvince

                                    // MARK: QUẬN/ HUYỆN
                                    self.selectedDistrict = self.temp_selectedDistrict
                                    self.selectedDistrictID = self.temp_selectedDistrictID
                                } else {
                                    // MARK: TÌNH TRẠNG
                                    self.selectedStatusMap = self.temp_selectedStatus

                                    if !self.isFromDiscover {
                                        // MARK: TỈNH/ THÀNH PHỐ
                                        self.selectedCityMap = self.temp_selectedCity
                                        self.selectedProvinceMap = self.temp_selectedProvince
                                    }

                                    // MARK: QUẬN/ HUYỆN
                                    self.selectedDistrictMap = self.temp_selectedDistrict
                                    self.selectedDistrictIDMap = self.temp_selectedDistrictID
                                }
                                if self.isFromMap {
                                    self.isTapFilter = true

                                    var count = 0
                                    for i in 0 ..< self.selectedStatusMap.count {
                                        if !self.selectedStatusMap[i].enable {
                                            count += 1
                                        }
                                    }
                                    if count == self.selectedStatusMap.count
                                        && self.selectedCityMap == []
                                        && self.selectedProvinceMap == []
                                        && self.selectedDistrictMap == []
                                        && self.selectedDistrictIDMap == [] {
                                        self.isFilter = false
                                    } else {
                                        self.isFilter = true
                                    }
                                    self.isNextOld = false
                                } else {
                                    self.isFromFilter = true
                                    self.isNext = true
                                }
                            }) {
                                ZStack {
                                    TextCustom(text: NSLocalizedString("filter_search", comment: ""), font: MEDIUM, size: 18, color: .white)
                                }.frame(width: FULL_W - 40, height: H(49))
                                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.5176470588, green: 0.3098039216, blue: 0.7254901961, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(5)
                                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .offset(y: dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearchCity) })) == nil ? 0 : H(44))
                                .offset(y: dataLocalDistrict.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearchDistrict) })) == nil ? 0 : H(44))
                                .padding(.top, H(
                                    temp_selectedCity.count == 0 ? 144:
                                        temp_selectedCity.count > 1 ? 99 : 20))
                                .padding(.bottom, FULL_H <= 667 || FULL_H == 736 ? H(40) : 0)
                                .padding(.bottom, dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearchCity) })) == nil ? 0 : H(44))
                                .padding(.bottom, dataLocalDistrict.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearchDistrict) })) == nil ? 0 : H(44))
                        }.frame(width: FULL_W)
                            .offset(y:
                                    isFromMap ? isTapTextFieldDistrict ? H(-200) : 0
                                    : keyboardHeight > 0 && temp_selectedCity.count == 1 ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -445: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -445: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -415: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -415: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -445 : 0 // iPhone 11 Pro
                                ): keyboardHeight > 0 ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -300: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -300: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -270: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -270: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -300 : 0): 0 // iPhone 11 Pro
                            )
                    }.resignKeyboardOnDragGesture()
                }.animation(.easeInOut(duration: 0.1))
                NavigationLink(destination:
                        SearchView(
                            closeSideMenu: { self.closeSideMenu() },
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            isNextSideMenu: $isNextSideMenu,
                            selectedMenuPurple: $selectedMenuPurple,
                            selectedCorlor: $selectedCorlor,
                            isNextOld: $isNext,
                            selectedStatus: $selectedStatus,
                            project_status: $project_status,
                            selectedProject: $selectedProject,
                            setting_type: $setting_type,
                            selectedCity: $selectedCity,
                            selectedProvince: $selectedProvince,
                            selectedDistrict: $selectedDistrict,
                            selectedDistrictID: $selectedDistrictID,
                            isFromFilter: $isFromFilter,
                            province_id: $selectedProvince),
                    isActive: $isNext) {
                    EmptyView()
                }
            }.keyboardAppear(keyboardHeight: $keyboardHeight)
                .onAppear {
                    self.filterViewModel.fetchDataFilterStatus(language: VIETNAM)
                    self.filterViewModel.fetchDataFilterProject(language: VIETNAM)
                    self.filterViewModel.fetchDataFilterCity()
                    self.filterViewModel.fetchDataFilterDistrict(province_id: -1)

                    // MARK: TỈNH/ THÀNH PHỐ
                    self.temp_selectedCity = self.isFromMap ? self.selectedCityMap : self.selectedCity
                    self.temp_selectedProvince = self.isFromMap ? self.selectedProvinceMap : self.selectedProvince

                    if !self.isFromFilter {
                        // MARK: TÌNH TRẠNG
//                    self.filterViewModel.vldFilterStatusList.sink { rs in
//                        if !self.isFromFilter {
//                            self.dataLocalStatus = self.filterViewModel.filterStatusList ?? []
//                            self.selectedStatus = []
//                            for i in 0 ..< self.dataLocalStatus.count {
//                                self.selectedStatus.append(typeStatusFilter(id: self.dataLocalStatus[i].id ?? 0, name: self.dataLocalStatus[i].name ?? "", enable: false, index: i))
//                            }
//                            for i in 0 ..< self.selectedStatus.count {
//                                for j in 0 ..< self.temp_selectedStatus.count {
//                                    if self.selectedStatus[i].id == self.temp_selectedStatus[j].id {
//                                        self.selectedStatus[i].enable = self.temp_selectedStatus[j].enable
//                                    }
//                                }
//
//                            }
//                            self.temp_selectedStatus = self.selectedStatus
//                            self.isHasDataStatus = rs
//                        }
//                    }.store(in: &self.disposables)

                        // MARK: DỰ ÁN
                        self.filterViewModel.vldFilterProjectList.sink { rs in
                            if !self.isFromFilter {
                                self.dataLocalProject = [FilterProjectListModel(type_id: 0, type_name: "Tất cả")]
                                self.dataLocalProject.append(contentsOf: (self.filterViewModel.filterProjectList ?? []).sorted(by: { ($0.type_id ?? 0) < ($1.type_id ?? 0) }))
                                self.selectedProject = []
                                for i in 0 ..< self.dataLocalProject.count {
                                    self.selectedProject.append(typeProjectFilter(id: self.dataLocalProject[i].type_id ?? 0, name: self.dataLocalProject[i].type_name ?? "", enable: i == 0 ? true : false, index: i))
                                }
                                self.temp_selectedProject = self.selectedProject
                                self.isHasDataProject = true
                            }
                        }.store(in: &self.disposables)

                        // MARK: TỈNH/ THÀNH PHỐ
                        self.filterViewModel.vldFilterCityList.sink { rs in
                            if !self.isFromFilter {
                                self.dataLocalCity = self.filterViewModel.filterCityList ?? []
                            }
                        }.store(in: &self.disposables)

                        // MARK: QUẬN/ HUYỆN
                        if self.temp_selectedProvince.count == 1 {
                            self.filterViewModel.fetchDataFilterDistrict(province_id: self.temp_selectedProvince[0])
                            self.filterViewModel.vldFilterDistrictList.sink { rs in
                                if !self.isFromFilter {
                                    self.dataLocalDistrict = self.filterViewModel.filterDistrictList ?? []
                                    self.isAddProvince = false
                                }
                            }.store(in: &self.disposables)
                        }
                    }

                    if self.isFromMap {
                        // MARK: TÌNH TRẠNG
                        self.temp_selectedStatus = self.selectedStatusMap
                    }

                    self.temp_setting_type = self.setting_type

                    // MARK: QUẬN/ HUYỆN
                    self.temp_selectedDistrict = self.isFromMap ? self.selectedDistrictMap : self.selectedDistrict
                    self.temp_selectedDistrictID = self.isFromMap ? self.selectedDistrictIDMap : self.selectedDistrictID
                }.onDisappear {
                    UIApplication.shared.endEditing()
                    UITableView.appearance().isScrollEnabled = true
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct CityAPILocal: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var province_id: Int
}

struct DistrictAPILocal: Identifiable, Hashable {
    var id = UUID()
    var name: String
    var province_id: Int
}

struct FilterDistrict: View {
    @Binding var isTapTextFieldDistrict: Bool
    @Binding var selectedDistrict: [String]
    @Binding var selectedDistrictID: [Int]
    @Binding var strSearch: String
    @Binding var dataLocalDistrict: [FilterDistrictListModel]

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            TextCustom(text: NSLocalizedString("filter_district", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                .padding(.leading, 20)
                .padding(.top, H(10))
                .padding(.bottom, H(12))
            ZStack (alignment: .top) {
                // MARK: TEMP UI ==================================================
                if dataLocalDistrict.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) != nil {
                    VStack (alignment: .leading, spacing: 0) {
                        ForEach(dataLocalDistrict.filter {
                            return ($0.name ?? "").localizedStandardContains(strSearch)
                        }, id: \.self) { item in
                            VStack (alignment: .leading, spacing: 0) {
                                Rectangle().frame(width: W(1), height: H(1)).foregroundColor(.clear)
                                TextCustom(text: " ", font: MEDIUM, size: 16, color: .clear)
                                    .padding(.vertical, H(14))
                            }
                        }
                    }.frame(width: FULL_W - 40, height: H(156), alignment: .leading)
                        .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                        .cornerRadius(5, corners: [.bottomLeft, .bottomRight])
                        .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                        .offset(y: H(44) - 1)
                }
                // MARK: ==========================================================
                ZStack (alignment: .leading) {
                    ImageCustom(name: "searchWhite", w: 18, h: 18)
                        .padding(.horizontal, W(16))
                    ZStack (alignment: .leading) {
                        TextCustom(text: NSLocalizedString("filter_district_search", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                            .fixedSize(horizontal: true, vertical: false)
                            .opacity(strSearch.isEmpty ? 1 : 0)
                        TextField("", text: $strSearch, onEditingChanged: { rs in
                            if rs {
                                self.isTapTextFieldDistrict = true
                            } else {
                                self.isTapTextFieldDistrict = false
                            }
                            UITableView.appearance().isScrollEnabled = false
                        }).font(.custom(REGULAR, size: H(14)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                            .padding(.trailing, W(42))
                            .frame(height: H(14))
                        HStack {
                            Spacer()
                            Button(action: {
                                self.strSearch = ""
                            }) {
                                ZStack (alignment: .trailing) {
                                    ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                    ImageCustom(name: "deleteAll", w: 14, h: 14)
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .offset(x: W(-3.5))
                                .opacity(strSearch.isEmpty ? 0 : 1)
                        }.padding(.trailing, W(16))
                    }.padding(.leading, W(49.7))
                }.frame(height: H(44))
                    .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                    .cornerRadius(7, corners:
                            dataLocalDistrict.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) == nil ?
                        [.bottomLeft, .bottomRight, .topLeft, .topRight]: [.topLeft, .topRight])
                    .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                    .padding(.horizontal, 20)
                if !strSearch.isEmpty && dataLocalDistrict.firstIndex(where: ({ ($0.name?.localizedStandardContains(strSearch))! })) != nil {
                    ScrollView(showsIndicators: false) {
                        VStack (alignment: .leading, spacing: 0) {
                            ForEach(dataLocalDistrict.filter {
                                return ($0.name ?? "").localizedStandardContains(strSearch)
                            }, id: \.self) { item in
                                VStack (alignment: .leading, spacing: 0) {
                                    Rectangle()
                                        .frame(width: W(55), height: H(1))
                                        .foregroundColor(.init(#colorLiteral(red: 0.8486694694, green: 0.8487718701, blue: 0.8486347198, alpha: 1)))
                                    TextCustom(text: item.name ?? "", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.2684262395, green: 0.2684628665, blue: 0.2684137821, alpha: 1)).onTapGesture {
                                        self.AppendSearchResult(districtName: item.name ?? "", district_id: item.district_id ?? 0)
                                    }.padding(.vertical, H(14))
                                }
                            }
                        }.padding(.leading, W(21))
                            .frame(width: FULL_W - 40, alignment: .leading)
                    }.frame(height: H(156))
                        .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                        .cornerRadius(5, corners: [.bottomLeft, .bottomRight])
                        .offset(y: H(44) - 1)
                }
            }
            if selectedDistrict.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: W(12)) {
                        ForEach(self.selectedDistrict, id: \.self) { i in
                            SearchTag(
                                selectedDistrict: self.$selectedDistrict,
                                selectedDistrictID: self.$selectedDistrictID,
                                selected: self.$selectedDistrict,
                                selectedID: self.$selectedDistrictID,
                                title: i)
                        }
                    }.padding(.horizontal, 20)
                }.padding(.top, H(19))
                    .offset(y: dataLocalDistrict.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) == nil ? 0 : H(44))
            }
        }.onAppear {
            self.strSearch = ""
        }
    }

    func AppendSearchResult(districtName: String, district_id: Int) {
        var count = 0

        if selectedDistrict.count == 0 {
            self.selectedDistrict.append(districtName)
            self.selectedDistrictID.append(district_id)
            // self.strSearch = ""
        } else {
            for i in 0 ..< selectedDistrict.count {
                if districtName == self.selectedDistrict[i] {
                    count += 1
                }
            }
            if count == 0 {
                self.selectedDistrict.append(districtName)
                self.selectedDistrictID.append(district_id)
                // self.strSearch = ""
            }
        }
    }
}

struct FilterCity: View {
    @Binding var selectedCity: [String]
    @Binding var selectedProvince: [Int]
    @Binding var strSearch: String
    @Binding var selectedDistrict: [String]
    @Binding var selectedDistrictID: [Int]
    @Binding var dataLocalCity: [FilterCityListModel]
    @Binding var isAddProvince: Bool

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            TextCustom(text: NSLocalizedString("filter_city", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                .padding(.leading, 20)
                .padding(.top, H(10))
                .padding(.bottom, H(12))
            ZStack (alignment: .top) {
                // MARK: TEMP UI ==================================================
                if dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) != nil {
                    VStack (alignment: .leading, spacing: 0) {
                        ForEach(dataLocalCity.filter {
                            return ($0.name ?? "").localizedStandardContains(strSearch)
                        }, id: \.self) { item in
                            VStack (alignment: .leading, spacing: 0) {
                                Rectangle().frame(width: W(1), height: H(1)).foregroundColor(.clear)
                                TextCustom(text: " ", font: MEDIUM, size: 16, color: .clear)
                                    .padding(.vertical, H(14))
                            }
                        }
                    }.frame(width: FULL_W - 40, height: H(156), alignment: .leading)
                        .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                        .cornerRadius(5, corners: [.bottomLeft, .bottomRight])
                        .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                        .offset(y: H(44) - 1)
                }
                // MARK: ==========================================================
                ZStack (alignment: .leading) {
                    ImageCustom(name: "searchWhite", w: 18, h: 18)
                        .padding(.horizontal, W(16))
                    ZStack (alignment: .leading) {
                        TextCustom(text: NSLocalizedString("filter_city_search", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                            .fixedSize(horizontal: true, vertical: false)
                            .opacity(strSearch.isEmpty ? 1 : 0)
                        TextField("", text: $strSearch, onEditingChanged: { result in
                            UITableView.appearance().isScrollEnabled = false
                        })
                            .font(.custom(REGULAR, size: H(14)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                            .padding(.trailing, W(42))
                            .frame(height: H(14))
                        HStack {
                            Spacer()
                            Button(action: {
                                self.strSearch = ""
                            }) {
                                ZStack (alignment: .trailing) {
                                    ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                    ImageCustom(name: "deleteAll", w: 14, h: 14)
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .offset(x: W(-3.5))
                                .opacity(strSearch.isEmpty ? 0 : 1)
                        }.padding(.trailing, W(16))
                    }.padding(.leading, W(49.7))
                }.frame(height: H(44))
                    .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                    .cornerRadius(7, corners: dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) == nil ? [.bottomLeft, .bottomRight, .topLeft, .topRight] : [.topLeft, .topRight])
                    .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                    .padding(.horizontal, 20)
                if !strSearch.isEmpty && dataLocalCity.firstIndex(where: ({ ($0.name?.localizedStandardContains(strSearch))! })) != nil {
                    ScrollView(showsIndicators: false) {
                        VStack (alignment: .leading, spacing: 0) {
                            ForEach(dataLocalCity.filter {
                                return ($0.name ?? "").localizedStandardContains(strSearch)
                            }, id: \.self) { item in
                                VStack (alignment: .leading, spacing: 0) {
                                    Rectangle()
                                        .frame(width: W(55), height: H(1))
                                        .foregroundColor(.init(#colorLiteral(red: 0.8486694694, green: 0.8487718701, blue: 0.8486347198, alpha: 1)))
                                    TextCustom(text: item.name ?? "", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.2684262395, green: 0.2684628665, blue: 0.2684137821, alpha: 1)).onTapGesture {
                                        self.AppendSearchResult(provinceName: item.name ?? "", provinceID: item.province_id ?? 0)
                                        self.isAddProvince = true
                                    }.padding(.vertical, H(14))
                                }
                            }
                        }.padding(.leading, W(21))
                            .frame(width: FULL_W - 40, alignment: .leading)
                    }.frame(height: H(156))
                        .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                        .cornerRadius(5, corners: [.bottomLeft, .bottomRight])
                        .offset(y: H(44) - 1)
                }
            }
            if selectedCity.count > 0 {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: W(12)) {
                        ForEach(self.selectedCity, id: \.self) { i in
                            SearchTag(
                                selectedDistrict: self.$selectedDistrict,
                                selectedDistrictID: self.$selectedDistrictID,
                                selected: self.$selectedCity,
                                selectedID: self.$selectedProvince,
                                title: i
                            )
                        }
                    }.padding(.horizontal, 20)
                }.padding(.top, H(19))
                    .offset(y: dataLocalCity.firstIndex(where: ({ ($0.name ?? "").localizedStandardContains(strSearch) })) == nil ? 0 : H(44))
            }
        }
    }

    func AppendSearchResult(provinceName: String, provinceID: Int) {
        var count = 0

        if selectedCity.count == 0 {
            self.selectedCity.append(provinceName)
            self.selectedProvince.append(provinceID)
        } else {
            for i in 0 ..< selectedCity.count {
                if provinceName == self.selectedCity[i] {
                    count += 1
                }
            }
            if count == 0 {
                self.selectedCity.append(provinceName)
                self.selectedProvince.append(provinceID)
            }
            if selectedCity.count > 1 {
                self.selectedDistrict = []
                self.selectedDistrictID = []
            }
        }
    }
}

struct SearchTag: View {
    @Binding var selectedDistrict: [String]
    @Binding var selectedDistrictID: [Int]
    @Binding var selected: [String]
    @Binding var selectedID: [Int]
    @State var title = ""

    var body: some View {
        HStack (spacing: W(12)) {
            TextCustom(text: self.title, font: MEDIUM, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                .fixedSize(horizontal: true, vertical: false)
            ImageCustom(name: "deleteAllPurple", w: 13.7, h: 13.7)
                .onTapGesture {
                    self.PopSearchResult()
            }
        }.padding(.horizontal, W(16))
            .frame(height: H(32))
            .background(Color.init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)))
            .cornerRadius(5)
    }

    func PopSearchResult() {
        var index = -1
        for i in 0 ..< selected.count {
            if title == self.selected[i] {
                index = i
            }
        }
        if index != -1 {
            self.selected.remove(at: index)
            self.selectedID.remove(at: index)
        }
        if selected.count == 0 {
            self.selectedDistrict = []
            self.selectedDistrictID = []
        }
    }
}

struct FilterStatus: View {
    @Binding var selectedStatus: [typeStatusFilter]
    @Binding var dataLocalStatus: [FilterStatusListModel]
    @Binding var isHasDataStatus: Bool

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            TextCustom(text: NSLocalizedString("filter_status", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                .padding(.leading, 20)
                .padding(.bottom, H(12))
            HStack (spacing: 14) {
                ForEach(dataLocalStatus.enumeratedArray(), id: \.element) { index, data in
                    FilterButton(selected: self.$selectedStatus, data: data, index: index)
                }
                Spacer()
            }.padding(.leading, 20)
                .padding(.bottom, H(24))
        }.frame(height: H(84))
    }
}

struct FilterProject: View {
    @Binding var selectedProject: [typeProjectFilter]
    @Binding var setting_type: [Int]
    @Binding var dataLocalProject: [FilterProjectListModel]
    @Binding var isHasDataProject: Bool
    @State var heightProject: CGFloat = (((FULL_W - 100) / 4) + 20) * CGFloat((Double(10) / 4).rounded(.up))

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            TextCustom(text: NSLocalizedString("filter_project", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                .padding(.bottom, H(12))
            if isHasDataProject {
                QGrid(dataLocalProject, columns: 4, vSpacing: 23, hSpacing: 20, vPadding: 0, hPadding: 0) { data in
                    FilterProjectButton(
                        data: data,
                        setting_type: self.$setting_type,
                        selectedProject: self.$selectedProject
                    )
                }.frame(width: FULL_W - 20 - 20, height: (((FULL_W - 109) / 4) + 20) * CGFloat((Double(self.dataLocalProject.count) / 4).rounded(.up)))
            } else {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(width: FULL_W - 40, height: heightProject)
            }
        }
    }
}

struct FilterProjectButton: View {
    @State var data = FilterProjectListModel(type_id: 0, type_name: "")
    @Binding var setting_type: [Int]
    @Binding var selectedProject: [typeProjectFilter]

    var body: some View {
        ZStack {
            Button(action: {
                if self.setting_type.count > 1 {
                    self.selectedProject[self.data.type_id ?? 0].enable = false
                    self.SearchContentMarkCancel()
                }
            }) {
                ZStack (alignment: .top) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)))
                        .frame(width: (FULL_W - 109) / 4, height: (FULL_W - 109) / 4)
                        .cornerRadius(7)
                    ImageCustom(name:
                            (data.type_id ?? 0) == 0 ? "allPurple":
                            (data.type_id ?? 0) == 1 ? "apartmentPurple":
                            (data.type_id ?? 0) == 2 ? "duplexPurple":
                            (data.type_id ?? 0) == 3 ? "officePurple":
                            (data.type_id ?? 0) == 4 ? "studioPurple":
                            (data.type_id ?? 0) == 5 ? "pentHousePurple":
                            (data.type_id ?? 0) == 6 ? "shopHousePurple":
                            (data.type_id ?? 0) == 7 ? "villaPurple":
                            (data.type_id ?? 0) == 8 ? "singleVillaPurple" : "duplexVillaPurple"
                        , w: 30, h: 30)
                        .padding(.top, H(9))
                    VStack {
                        Spacer()
                        TextCustom(text: data.type_name ?? "", font: REGULAR, size: 11, lineLimit: 1, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .padding(.bottom, H(13))
                    }
                }
            }.buttonStyle(ButtonTapScale())
                .opacity(self.selectedProject[data.type_id ?? 0].enable ? 1 : 0)

            Button(action: {
                self.FilterResult()
                self.SearchContentMark()
            }) {
                ZStack (alignment: .top) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: ((FULL_W - 109) / 4) - 3, height: ((FULL_W - 109) / 4) - 3)
                        .overlay(RoundedRectangle(cornerRadius: 7).stroke(Color.init(#colorLiteral(red: 0.5109422803, green: 0.5110063553, blue: 0.510920465, alpha: 1)), lineWidth: 1.5))
                        .cornerRadius(7)
                    ImageCustom(name:
                            (data.type_id ?? 0) == 0 ? "allGray":
                            (data.type_id ?? 0) == 1 ? "apartmentGray":
                            (data.type_id ?? 0) == 2 ? "duplexGray":
                            (data.type_id ?? 0) == 3 ? "officeGray":
                            (data.type_id ?? 0) == 4 ? "studioGray":
                            (data.type_id ?? 0) == 5 ? "pentHouseGray":
                            (data.type_id ?? 0) == 6 ? "shopHouseGray":
                            (data.type_id ?? 0) == 7 ? "villaGray":
                            (data.type_id ?? 0) == 8 ? "singleVillaGray" : "duplexVillaGray"
                        , w: 30, h: 30)
                        .padding(.top, H(9))
                    VStack {
                        Spacer()
                        TextCustom(text: data.type_name ?? "", font: REGULAR, size: 11, lineLimit: 1, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                            .padding(.bottom, H(13))
                    }
                }
            }.buttonStyle(ButtonTapScale())
                .opacity(self.selectedProject[data.type_id ?? 0].enable ? 0 : 1)
        }.animation(.easeInOut(duration: 0.1))
    }

    func FilterResult() {
        var count = 0

        if (data.type_id ?? 0) == 0 {
            for i in 0 ..< selectedProject.count {
                selectedProject[i].enable = false
            }
            selectedProject[0].enable = true
            setting_type = [0]
        } else {
            selectedProject[0].enable = false
            selectedProject[data.type_id ?? 0].enable = true
            for i in 0 ..< selectedProject.count {
                if selectedProject[i].enable {
                    count += 1
                }
            }
            if !selectedProject[0].enable && count == selectedProject.count - 1 {
                for i in 0 ..< selectedProject.count {
                    selectedProject[i].enable = false
                }
                selectedProject[0].enable = true
            }
        }
    }

    func SearchContentMark() {
        var duplicate = 0

        if (data.type_id ?? 0) == 0 {
            setting_type = [0]
        } else {
            for i in 0 ..< setting_type.count {
                if (data.type_id ?? 0) == self.setting_type[i] {
                    duplicate += 1
                }
            }
            if duplicate == 0 {
                self.setting_type.append(data.type_id ?? 0)
            }
            for i in 0 ..< setting_type.count {
                if setting_type[i] == 0 {
                    setting_type.remove(at: i)
                    break
                }
            }
            if setting_type.count == selectedProject.count - 1 {
                setting_type = [0]
            }
        }
    }

    func SearchContentMarkCancel() {
        for i in 0 ..< setting_type.count {
            if data.type_id ?? 0 == self.setting_type[i] {
                setting_type.remove(at: i)
                break
            }
        }
    }
}

struct FilterButton: View {
    @Binding var selected: [typeStatusFilter]
    @State var data: FilterStatusListModel
    @State var index = 0

    var body: some View {
        ZStack {
            Button(action: {
                self.selected[self.index].enable = false
            }) {
                TextCustom(text: data.name ?? "", font: MEDIUM, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    .padding(.horizontal, W(16))
                    .frame(height: H(32))
                    .background(Color.init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)))
                    .cornerRadius(5)
            }.buttonStyle(ButtonTapScale())
                .opacity(selected[index].enable ? 1 : 0)
            Button(action: {
                self.selected[self.index].enable = true
            }) {
                TextCustom(text: data.name ?? "", font: MEDIUM, size: 14, color: #colorLiteral(red: 0.5109422803, green: 0.5110063553, blue: 0.510920465, alpha: 1))
                    .padding(.horizontal, W(16))
                    .frame(height: H(32))
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.init(#colorLiteral(red: 0.5109422803, green: 0.5110063553, blue: 0.510920465, alpha: 1)), lineWidth: 1.5))
                    .cornerRadius(5)
            }.buttonStyle(ButtonTapScale())
                .opacity(selected[index].enable ? 0 : 1)
        }.animation(.easeInOut(duration: 0.1))
    }
}
