

import SwiftUI

struct ProjectGroundPlanMapView: View {
    @State var isNextOld = false
    @State var isNext = false
    @State var tempBool = false
    @State var strSearch = ""
    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                MapViewTemp()
                Rectangle()
                    .foregroundColor(Color.init(#colorLiteral(red: 0.1313549012, green: 0.1411759833, blue: 0.1546415441, alpha: 0.08800551471)))
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
                    callFunc: { },
                    textFunc: { },
                    isCallAndTextWhite: true
                ).padding(.top, H(40))
                NavigationLink(destination: ProjectGroundPlanMapDetail(isNext: self.$isNext, isNextOld: self.$isNextOld), isActive: self.$isNext) {
                    EmptyView()
                }
            }.edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .onTapGesture {
                    self.isNext = true
            }
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

