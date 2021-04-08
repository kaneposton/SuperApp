// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ProjectGroundPlanMapView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    
    @State var isNext = false
    @State var isNextChat = false
    @State var areaName = "Khu Stella"

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                MapViewTemp()
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isNext = true
                        self.isSideMenuAppear = false
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: H(100))
                Rectangle()
                    .opacity(isOpenSideMenu ? 0.75 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.closeSideMenu()
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: $isOpenSideMenu,
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "projectDetailHome_Plan",
                    title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName) | \(areaName)",
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
                    isCallAndTextWhite: true
                )
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
                        ProjectGroundPlanView(
                            areaName: $areaName,
                            isNextOld: $isNext,
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectName: $projectName,
                            isRoot: $isNextOld,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
