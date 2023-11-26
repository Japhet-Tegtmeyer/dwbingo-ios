//
//  WelcomeView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/12/23.
//

import SwiftUI
import AuthenticationServices

struct WelcomeView: View {
    @AppStorage("name_prefix") var namePrefix: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("name_suffix") var nameSuffix: String = ""
    @AppStorage("user_id") var userId: String = ""
    
    @Environment(\.colorScheme) var colorS
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("CircleDW")
                    .resizable()
                    .offset(y: 300)
                    .frame(width: 1000, height: 1000)
                
                VStack(spacing: 20) {
                    Image("Icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(999)
                        .shadow(color: .gray.opacity(0.3),
                                radius: 10)
                    
                    Text("Welcome to DWBingo")
                        .font(.system(size: 30))
                        .bold()
                        .accessibilityLabel("Welcome sign")
                    
                    SignInWithAppleButton(.continue) { request in
                        
                        request.requestedScopes = [.fullName]
                        
                    } onCompletion: { result in
                        
                        switch result {
                        case .success(let auth):
                            
                            switch auth.credential {
                            case let credential as ASAuthorizationAppleIDCredential:
                                
                                let userId = credential.user
                                
                                let namePrefix = credential.fullName?.namePrefix
                                let firstName = credential.fullName?.givenName
                                let lastName = credential.fullName?.familyName
                                let nameSuffix = credential.fullName?.nameSuffix
                                
                                self.userId = userId
                                
                                self.namePrefix = namePrefix ?? ""
                                self.firstName = firstName ?? ""
                                self.lastName = lastName ?? ""
                                self.nameSuffix = nameSuffix ?? ""
                                
                            default:
                                break
                            }
                            
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                        }
                        
                    }
                    .clipShape(Capsule())
                    .signInWithAppleButtonStyle(
                        colorS == .dark ? .white : .black
                    )
                    .frame(width: 350, height: 50)
                    .accessibilityLabel("Sign In With Apple button")
                    
                    NavigationLink {
                        NameView()
                    } label: {
                        Text("Try Another Way")
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .frame(width: 350, height: 50)
                            .background(.purple)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
