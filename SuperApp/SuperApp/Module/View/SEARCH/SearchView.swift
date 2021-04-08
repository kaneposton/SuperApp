// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SearchView: View {
    let closeSideMenu: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @Binding var isNextOld: Bool
    @State var strSearch = ""
    @State var listData_temp = [HomeProjectListModel]()

    @State var project_id = -1

    // MARK: VARIABLE FOR FILTER ======================================
    // MARK: TÌNH TRẠNG
    @Binding var selectedStatus: [typeStatusFilter]
    @Binding var project_status: [Int]
    
    // MARK: DỰ ÁN
    @Binding var selectedProject: [typeProjectFilter]
    @Binding var setting_type: [Int]

    // MARK: TỈNH/ THÀNH PHỐ
    @Binding var selectedCity: [String]
    @Binding var selectedProvince: [Int]

    // MARK: QUẬN/ HUYỆN
    @Binding var selectedDistrict: [String]
    @Binding var selectedDistrictID: [Int]
    // ================================================================

    @Binding var isFromFilter: Bool
    @Binding var province_id: [Int]
    
    @State var isNext = false
    @State var projectName = ""
    @State var projectURL = ""
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
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "filter_result",
                        backFunc: {                           
                            self.isNextOld = false                            
                            UIApplication.shared.endEditing()
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true,
                        isHideIconFilter: true
                    )

                    //MARK:  BODY
                    ListDataView(
                        isTapSearch: $isTapSearch,
                        projectURL: $projectURL,
                        project_id: $project_id,
                        projectName: $projectName,
                        isNext: $isNext,
                        data: $listData_temp,
                        strSearch: $strSearch,
                        setting_type: $setting_type,
                        province_id: $province_id,
                        district_id: $selectedDistrictID,
                        project_status: $project_status
                    )
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
            }.onAppear {
                self.tempPullScreen = true
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
