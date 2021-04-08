// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct UtilitiesView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    
    @State var isNextChat = false

    @State var language = VIETNAM
    @ObservedObject var utilitiesViewModel = UtilitiesViewModel()
    @State var isHaveArea = false
    @State var isHaveUtilities = false
    @State var utilitiesListArea = [UtilitiesListAreaModel]()
    @State var utilitiesListUtilities = [UtilitiesListUtilitiesModel]()
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
                    title: "projectDetailHome_Ulities",
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
//                self.utilitiesViewModel.fetchDataUtilities(language: self.language, projectId: self.project_id)
//                self.utilitiesViewModel.vldUtilitiesListUtilities.sink { rs in
//                    self.utilitiesListUtilities = self.utilitiesViewModel.utilitiesListUtilities ?? []
//                    self.isHaveArea = true
//                }.store(in: &self.disposables)
//                self.utilitiesViewModel.vldUtilitiesListArea.sink { rs in
//                    self.utilitiesListArea = self.utilitiesViewModel.utilitiesListArea ?? []
//                    self.isHaveArea = true
//                }.store(in: &self.disposables)
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}
