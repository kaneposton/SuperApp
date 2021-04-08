// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TabBarCustom: View {
    @Binding var selectedTabBar: Int

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                ZStack {
                    // MARK: TAB KHÁM PHÁ
                    HStack {
                        Button(action: {
                            self.selectedTabBar = 0
                        }) {
                            ImageCustom(name: selectedTabBar == 0 ? "home_purple" : "home_gray", w: 26, h: 26)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.leading, 20)
                        Spacer()
                    }

                    // MARK: TAB 1
                    HStack {
                        Button(action: {
                            self.selectedTabBar = 1
                        }) {
                            ImageCustom(name: selectedTabBar == 1 ? "project_purple" : "project_gray", w: 26, h: 26)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.leading, 10 + W(13) + FULL_W / 4 - W(39) / 2)
                        Spacer()
                    }
                    // MARK: TAB 2
                    Button(action: {
                        self.selectedTabBar = 2
                    }) {
                        ImageCustom(name: selectedTabBar == 2 ? "trading_purple" : "trading_gray", w: 26, h: 26)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))

                    // MARK: TAB 3
                    HStack {
                        Spacer()
                        Button(action: {
                            self.selectedTabBar = 3
                        }) {
                            ImageCustom(name: selectedTabBar == 3 ? "news_purple" : "news_gray", w: 26, h: 26)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.trailing, 10 + W(13) + FULL_W / 4 - W(39) / 2)
                    }

                    // MARK: TAB TÀI KHOẢN
                    HStack {
                        Spacer()
                        Button(action: {
                            self.selectedTabBar = 4
                        }) {
                            ImageCustom(name: selectedTabBar == 4 ? "user_purple" : "user_gray", w: 26, h: 26)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.trailing, 20)
                    }
                }.frame(width: FULL_W, height: FULL_H == 736 || FULL_H <= 667 ? 70 : 80)
                    .offset(y: FULL_H == 736 || FULL_H <= 667 ? -1 : -11)
            }.background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
        }.cornerRadius(0)
            .shadow(color: .init(#colorLiteral(red: 0.5813372462, green: 0.5813372462, blue: 0.5813372462, alpha: 0.2016802226)), radius: 3, y: -3)
            .edgesIgnoringSafeArea(.bottom)
    }
}
