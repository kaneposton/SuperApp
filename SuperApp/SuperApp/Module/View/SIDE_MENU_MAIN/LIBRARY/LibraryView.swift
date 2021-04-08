// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct LibraryView: View {
    let closeSideMenu: () -> Void
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var projectName: String
    @Binding var project_id: Int
    @Binding var projectURL: String
    @Binding var arrChatData: [chatData]
    
    @State var viewStatePicture = CGSize.zero
    @State var pictureIndex: CGFloat = 0
    @State var isNextChat = false
    @State var isNext = false
    @State var dataImage = imageListArr(content: "", imageName: "", label: "", index: 0)
    @State var isStartAnimation = false

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                VStack (spacing: H(12)) {
                    ZStack (alignment: .top) {
                        ZStack (alignment: .top) {
                            LibraryTabber(
                                textType: NSLocalizedString("library_image", comment: ""),
                                index: 0,
                                pictureIndex: self.$pictureIndex,
                                viewStatePicture: self.$viewStatePicture
                            )
                            LibraryTabber(
                                textType: "VIDEO",
                                index: 1,
                                pictureIndex: self.$pictureIndex,
                                viewStatePicture: self.$viewStatePicture
                            )
                            LibraryTabber(
                                textType: "VIEW AR",
                                index: 2,
                                pictureIndex: self.$pictureIndex,
                                viewStatePicture: self.$viewStatePicture
                            )
                        }.offset(x: self.viewStatePicture.width)
                            .padding(.top, H(86))
                        ZStack (alignment: .top) {
                            ImageLibraryView(
                                project_id: $project_id,
                                isSideMenuAppear: $isSideMenuAppear,
                                isNext: $isNext,
                                closeSideMenu: { self.closeSideMenu() }
                            ).opacity(pictureIndex == 0 ? 1 : 0)
                                .offset(x: pictureIndex == 0 ? 0 : -FULL_W)
                            VideoLibraryView(project_id: $project_id)
                                .opacity(pictureIndex == 1 ? 1 : 0)
                                .offset(x: pictureIndex == 1 ? 0 : pictureIndex == 0 ? FULL_W: -FULL_W)
                            ARLibraryView(project_id: $project_id)
                                .opacity(pictureIndex == 2 ? 1 : 0)
                                .offset(x: pictureIndex == 2 ? 0 : FULL_W)
                        }.animation(.easeInOut(duration: 0.2))
                            .padding(.top, H(125))
                    }
                    Spacer()
                }.animation(isStartAnimation ? .easeInOut(duration: 0.2) : .none)
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
                    title: "library_title",
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
                    isCallAndTextBlack: true
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
                        LibraryDetailView(
                            isNextOld: $isNext,
                            dataImage: $dataImage,
                            isOpenSideMenu: $isOpenSideMenu,
                            isSideMenuAppear: $isSideMenuAppear,
                            projectName: $projectName,
                            project_id: $project_id,
                            projectURL: $projectURL,
                            arrChatData: $arrChatData
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isStartAnimation = true
                }
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct LibraryTabber: View {
    @State var textType = ""
    @State var index: CGFloat = 0
    @Binding var pictureIndex: CGFloat
    @Binding var viewStatePicture: CGSize

    var body: some View {
        Button(action: {
            self.pictureIndex = self.index
            self.viewStatePicture.width =
                FULL_H == H_SE && FULL_W == W_SE ? -110 * self.pictureIndex: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? -130 * self.pictureIndex: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? -140 * self.pictureIndex: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? -135 * self.pictureIndex: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? -130 * self.pictureIndex : 0 // iPhone 11 Pro
        }) {
            ZStack {
                TextCustom(text: textType, size: 20, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)).opacity(self.pictureIndex == index ? 1 : 0)
                TextCustom(text: textType, font: REGULAR, size: 20, color: #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)).opacity(self.pictureIndex == index ? 0 : 1)
            }
        }.offset(x:
                FULL_H == H_SE && FULL_W == W_SE ? 110 * index: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 130 * index: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 140 * index: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 135 * index: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 130 * index : 0 // iPhone 11 Pro
        ).buttonStyle(ButtonTapScale())
            .animation(.easeInOut(duration: 0.2))
    }
}
