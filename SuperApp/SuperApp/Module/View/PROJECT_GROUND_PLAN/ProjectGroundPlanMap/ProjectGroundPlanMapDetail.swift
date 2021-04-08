

import SwiftUI

struct ProjectGroundPlanMapDetail: View {
    @Binding var isNext: Bool
    @Binding var isNextOld: Bool
    @State var tempBool = false
    @State var strSearch = ""
    @State var isOpenSideMenu = false
    @State var isOpenCall = false
    @State var isNextNews = false
    @State var isNextChat = false
    @State var animationSideMenu = [false, false, false, false, false, false, false, false, false]
    @State var isSideMenuAppear = false
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                MapViewTemp()
                Rectangle()
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1313549012, green: 0.1411759833, blue: 0.1546415441, alpha: 0.08800551471)))
                VStack{
                    NavigationWhite(
                        isOpenSideMenu: $tempBool,
                        isOpenCall: $tempBool,
                        strSearch: $strSearch,
                        title: "Mặt bằng",
                        title_2: "Dự án VTP",
                        backFunc: {
                            self.isNextOld = true
                            self.isNext = false
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { self.isOpenCall = true},
                        textFunc: {self.isNextChat = true },
                        isCallAndTextWhite: true
                    ).padding(.top, H(40))
                        
                }
               
            }.edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            .navigationBarTitle("")

    }

}


