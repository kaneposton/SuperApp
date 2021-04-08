// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI

struct SideMenu: View {
    @Binding var isOpenSideMenu: Bool
    @Binding var isLogOut: Bool
    @Binding var selectedMenu: Int
    @Binding var selectedDepartmentID: Int
    @Binding var departmentName: String
    @Binding var isChangeDepartment: Bool
    @Binding var isLogin: Bool

    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }.background(Color.init(#colorLiteral(red: 0.03224011883, green: 0.02067996003, blue: 0.009492428973, alpha: 0.4953446062)))
                .opacity(isOpenSideMenu ? 1 : 0)
                .animation(.easeInOut(duration: 0.2))
                .onTapGesture { self.isOpenSideMenu = false }
            HStack {
                MenuContent(
                    isOpenSideMenu: $isOpenSideMenu,
                    isLogOut: $isLogOut,
                    selectedMenu: $selectedMenu,
                    selectedDepartmentID: $selectedDepartmentID,
                    departmentName: $departmentName,
                    isChangeDepartment: $isChangeDepartment,
                    isLogin: $isLogin
                ).frame(width: W(360))
                    .background(Color.white)
                    .offset(x: isOpenSideMenu ? 0 : W(-370))
                    .animation(.easeInOut(duration: 0.3))
                Spacer()
            }
        }.edgesIgnoringSafeArea(.all)
    }
}

struct MenuContent: View {
    @Binding var isOpenSideMenu: Bool
    @Binding var isLogOut: Bool
    @Binding var selectedMenu: Int
    @Binding var selectedDepartmentID: Int
    @Binding var departmentName: String
    @Binding var isChangeDepartment: Bool
    @Binding var isLogin: Bool

    var body: some View {
        ZStack (alignment: .top) {
            Color.init(#colorLiteral(red: 0.9724639058, green: 0.9726034999, blue: 0.9724336267, alpha: 1)).edgesIgnoringSafeArea(.all)
        }
    }
}
