// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct WelcomeView: View {
    // MARK: SPLASH SCREEN
    @Binding var isAlreadySplash: Bool

    @Binding var isStartHome: Bool

    @State var animationWelcome = false
    @State var isNormal = false
    @State var version = "0.0.0"

    var body: some View {
        ZStack (alignment: .top) {
            Image("background")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            ZStack (alignment: .top) {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                    .edgesIgnoringSafeArea(.all)
                    .offset(y: isAlreadySplash ? 0 : isNormal ? 0 : FULL_H)
                VStack (spacing: H(isNormal ? 12 : 38)) {
                    Image("logoMinerva")
                        .resizable()
                        .frame(width: animationWelcome ? W(135) : FULL_W - W(200), height: animationWelcome ? W(135) : FULL_W - W(200))
                    VStack (spacing: H(5)) {
                        TextCustom(text: "MINERVA", size: 50, color: .white)
                        TextCustom(text: "TECHNOLOGY SOLUTIONS", font: REGULAR, size: 25, color: .white)
                    }
                }.scaleEffect(isNormal ? 0.8 : 1)
                    .offset(y: isNormal ? H(-175) : H(175))
                    .opacity(isAlreadySplash ? 0 : isNormal ? 0 : animationWelcome ? 1 : 0)
            }.animation(.easeInOut(duration: isStartHome ? 0.1 : 1.75))
            VStack (spacing: H(5)) {
                Spacer()
                TextCustom(text: "Version \(version)", font: LIGHT_ITALIC, size: 14, color: .white)
                TextCustom(text: "Publisher: Minerva Technology Solutions JSC", font: LIGHT_ITALIC, size: 14, color: .white)
            }.opacity(isAlreadySplash ? 0 : isNormal ? 0 : 1)
                .padding(.bottom, H(35))
                .animation(.easeInOut(duration: isStartHome ? 0.1 : 1.75))
        }.onAppear {
            self.animationWelcome = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.isNormal = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.isStartHome = true
            }
        }
    }
}
