// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct LocationView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    
    @State var isNextChat = false

    @ObservedObject var locationViewModel = LocationViewModel()
    @State var isHaveData = false
    @State var locationListModel = [LocationListModel]()
    @State var disposables = Set<AnyCancellable>()

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                MapViewTemp().edgesIgnoringSafeArea(.all)
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
                    title: "projectDetailHome_Map",
                    title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)",
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
            }.onAppear {
//                    self.locationViewModel.fetchDataLocation(projectId: self.project_id)
//                    self.locationViewModel.vldLlocationList.sink{ rs in
//                        self.locationListModel = self.locationViewModel.locationList ?? []
//                        self.isHaveData = true
//                        print(self.locationListModel)
//                    }.store(in: &self.disposables)
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
