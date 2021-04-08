// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct DiscoverDetailView: View {
    @Binding var isNextOld: Bool
    @Binding var detail: String
    let closeSideMenu: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @State var provinceId = 0

    @State var strSearch = ""
    @State var isNextFilterDiscover = false
    @State var listData = [HomeProjectListModel]()
    @State var disposables = Set<AnyCancellable>()

    @ObservedObject var viewModel = HomeViewModel()

    // MARK: VARIABLE FOR FILTER ================================
    @State var selectedStatus = [false, false]

    // MARK: DỰ ÁN
    @State var selectedProject = [true, false, false, false, false, false]
    @State var setting_type = [0]

    // MARK: LOẠI HÌNH DỰ ÁN
    @State var selectedType = [false, false, false]

    // MARK: TỈNH/ THÀNH PHỐ
    @State var selectedCity: [String] = []

    @State var selectedProvince: [Int] = []

    // MARK: QUẬN/ HUYỆN
    @State var selectedDistrict: [String] = []
    @State var selectedDistrictID: [Int] = []
    // ==========================================================

    @State var isNext = false
    @State var projectName = ""
    
    @State var projectURL = ""
    @State var project_id = -1
    @State var isTapSearch = false
    @State var tempPullScreen = false
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                if tempPullScreen { Text("") }
                VStack (spacing: 0) {
                    //MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: $isTapSearch,
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: $strSearch,
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: detail,
                        backFunc: {
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                        },
                        mapFunc: { },
                        filterFunc: { self.isNextFilterDiscover = true },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true)

                    //MARK: BODY
                    ListDataView(
                        isTapSearch: $isTapSearch,
                        projectURL: $projectURL,
                        project_id: $project_id,
                        projectName: $projectName,
                        isNext: $isNext,
                        data: $listData,
                        strSearch: $strSearch,
                        setting_type: Binding.constant([]),
                        province_id: Binding.constant([]),
                        district_id: Binding.constant([]),
                        project_status: Binding.constant([]),
                        isSell: true,
                        isFromDiscover: true,
                        provinceFromDiscover: provinceId
                    )
                    Spacer()
                }.edgesIgnoringSafeArea(.bottom)
                NavigationLink(destination:
                        SearchFilterView(
                            // MARK: MAP
                            isTapFilter: Binding.constant(false),
                            // MARK: TEMP
                            closeSideMenu: { self.closeSideMenu() },
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            isNextSideMenu: $isNextSideMenu,
                            selectedMenuPurple: $selectedMenuPurple,
                            selectedCorlor: $selectedCorlor,
                            isNextOld: $isNextFilterDiscover,
                            isFilter: Binding.constant(false),
                            isFromDiscover: true,
                            selectedStatusMap: Binding.constant([]),
                            selectedCityMap: Binding.constant([]),
                            selectedProvinceMap: Binding.constant([]),
                            selectedDistrictMap: Binding.constant([]),
                            selectedDistrictIDMap: Binding.constant([]),
                            selectedProvince: [provinceId]
                        ), isActive: $isNextFilterDiscover) {
                    EmptyView()
                }
                NavigationLink(destination:
                        ProjectHomeView(
                            closeSideMenu: { self.closeSideMenu() },
                            projectURL: $projectURL,
                            projectName: $projectName,
                            isNextOld: $isNext,
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            isNextSideMenu: $isNextSideMenu,
                            selectedMenuPurple: $selectedMenuPurple,
                            selectedCorlor: $selectedCorlor,
                            project_id: $project_id
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.onAppear {
            self.tempPullScreen = true
            self.viewModel.fetchDataProjectList(
                settingType: [0],
                provinceId: [self.provinceId],
                projectStatus: [0, 1],
                language: VIETNAM,
                districtId: []
            )
            self.viewModel.vldFilterProjectList.sink { rs in
                self.listData = self.viewModel.homeProjectList ?? []
            }.store(in: &self.disposables)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
