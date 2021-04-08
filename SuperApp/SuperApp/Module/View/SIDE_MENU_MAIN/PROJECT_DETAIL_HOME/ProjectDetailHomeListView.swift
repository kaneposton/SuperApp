// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ProjectDetailHomeListView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int

    @State var setting_type = [4, 2, 1]
    @State var strSearch = ""
    @State var isNextProjectFilter = false
    @State var isNextProjectHome = false
    @State var projectName = ""

    @State var project_id = -1

    @State var listData = [HomeProjectListModel]()
    @State var province_id_temp = [0]
    @State var district_id_temp = [736]
    @State var project_status_temp = [1]
    @State var projectURL = ""
    @State var isTapSearch = false
    @State var tempPullScreen = false
    
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
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
                        title: "home_project_list",
                        backFunc: {
                            self.isNextOld = false
                            UIApplication.shared.endEditing()
                        },
                        mapFunc: { },
                        filterFunc: { self.isNextProjectFilter = true },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true)

                    //MARK:  BODY
                    ListDataView(
                        isTapSearch: $isTapSearch,
                        projectURL: $projectURL,
                        project_id: $project_id,
                        projectName: $projectName,
                        isNext: $isNextProjectHome,
                        data: $listData,
                        strSearch: $strSearch,
                        setting_type: Binding.constant([]),
                        province_id: Binding.constant([]),
                        district_id: Binding.constant([]),
                        project_status: Binding.constant([]),
                        isSell: true,
                        dataSource: true
                    )
                }
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
                            isNextOld: $isNextProjectFilter,
                            isFilter: Binding.constant(false),
                            selectedStatusMap: Binding.constant([]),
                            selectedCityMap: Binding.constant([]),
                            selectedProvinceMap: Binding.constant([]),
                            selectedDistrictMap: Binding.constant([]),
                            selectedDistrictIDMap: Binding.constant([])
                        ), isActive: $isNextProjectFilter) {
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
            }.onAppear {
                self.tempPullScreen = true
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
