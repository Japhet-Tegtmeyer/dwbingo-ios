//
//  ChangeIconView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import SwiftUI

struct ChangeAppIconView: View {
    @StateObject var viewModel = ChangeAppIconViewModel()

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 11) {
                    ForEach(ChangeAppIconViewModel.appIcon) { appIcon in
                        HStack(spacing: 16) {
                            Image(uiImage: appIcon.preview)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)                                .cornerRadius(12)
                            Text(appIcon.description)
                                .font(.body17Medium)
                            Spacer()
                            CheckboxView(isSelected: viewModel.selectedAppIcon == appIcon)
                        }
                        .padding(EdgeInsets(top: 14, leading: 16, bottom: 14, trailing: 16))
                        .background(Color.grey7)
                        .cornerRadius(20)
                        .onTapGesture {
                            withAnimation {
                                viewModel.updateAppIcon(to: appIcon)
                            }
                        }
                    }
                }.padding(.horizontal)
                    .padding(.vertical, 40)
            }
        }
        .background(Color(UIColor.pageBackground).ignoresSafeArea())
    }
}

struct ChangeAppIconView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAppIconView()
    }
}

struct CheckboxView: View {
    let isSelected: Bool

    private var image: UIImage {
        let imageName = isSelected ? "icon-checked" : "icon-unchecked"
        return UIImage(imageLiteralResourceName: imageName)
    }

    var body: some View {
        Image(uiImage: image)
    }
}
