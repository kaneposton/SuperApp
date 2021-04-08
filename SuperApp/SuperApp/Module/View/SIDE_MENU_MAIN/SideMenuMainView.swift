// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SideMenuMainView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var selectedMenuPurple: Int
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    
    var body: some View {
        ZStack (alignment: .top) {
            // MARK: GIỚI THIỆU
            if selectedMenuPurple == 1 {
                ProjectIntroductionView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: MẶT BẰNG
            if selectedMenuPurple == 2 {
                ProjectGroundPlanMapView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: VỊ TRÍ
            if selectedMenuPurple == 3 {
                LocationView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: TIỆN ÍCH
            if selectedMenuPurple == 4 {
                UtilitiesView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: BÁN HÀNG
            if selectedMenuPurple == 5 {
                SalesView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: THƯ VIỆN
            if selectedMenuPurple == 6 {
                LibraryView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: TIN TỨC
            if selectedMenuPurple == 7 {
                NewsView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectName: $projectName,
                    project_id: $project_id,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }

            // MARK: LIÊN HỆ
            if selectedMenuPurple == 8 {
                ProjectContactView(
                    closeSideMenu: { self.closeSideMenu() },
                    isNextOld: $isNextOld,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    projectURL: $projectURL,
                    arrChatData: $arrChatData
                )
            }
        }
    }
}
