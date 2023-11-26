//
//  RulesSheet.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/19/23.
//

import SwiftUI

struct RulesSheet: View {
    
    // MARK: - Environment Properties
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - App Storage Properties
    
    @AppStorage("agreed") var agreed: Bool = false
    
    var body: some View {
        ZStack {
            
            // MARK: - Scrollable Content
            
            ScrollView {
                HStack {
                    
                    // MARK: - Title Icon
                    
                    Image(systemName: "sparkles.rectangle.stack.fill")
                        .imageScale(.large)
                        .bold()
                        .foregroundStyle(.purple)
                    
                    // MARK: - Title Text
                    
                    Text("Welcome to DWBingo")
                        .bold()
                        .font(.title3)
                }
                .padding(.top, 32)
                
                // MARK: - Introduction Text
                
                Text("To continue you'll need to read and agree to the terms below")
                    .font(.caption)
                    .frame(width: 250)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.gray)
                    .padding(8)
                
                // MARK: - Terms and Conditions
                
                VStack(alignment: .leading) {
                    
                    // MARK: - Term 1
                    
                    HStack {
                        Text("1")
                            .padding(8)
                            .background(.purple)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                        
                        Text("You may only have one card")
                            .font(.headline)
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    Text("You are permitted to have one personal bingo card and one minor card.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    // MARK: - Term 2
                    
                    HStack {
                        Text("2")
                            .padding(8)
                            .background(.purple)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                        
                        Text("You may only reset your card five times")
                            .font(.headline)
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    Text("You are permitted to reset your or your child's card five times. After five times, the button will disable. You can reset the limit on settings once.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    // MARK: - Term 3
                    
                    HStack {
                        Text("3")
                            .padding(8)
                            .background(.purple)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                        
                        Text("Try to have a unique card")
                            .font(.headline)
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    Text("Please attempt to have a different card than others in your group.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    // MARK: - Privacy Section
                    
                    HStack {
                        Image(systemName: "hand.raised.fill")
                            .imageScale(.small)
                            .padding(6)
                            .background(.purple)
                            .clipShape(Circle())
                            .foregroundStyle(.white)
                        
                        Text("Privacy")
                            .font(.headline)
                            .frame(width: 250)
                            .offset(x: -95)
                    }
                    .padding(.top)
                    .padding(.leading)
                    
                    Text("Your privacy matters to us. All data is stored on the device and is not linked to you.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.horizontal)
                    
                    // MARK: - Agree Button
                    
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                            agreed = true
                        } label: {
                            Text("Agree")
                                .padding()
                                .padding(.horizontal, 50)
                                .background(.purple)
                                .foregroundStyle(.white)
                                .bold()
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .padding()
                        }
                        .padding()
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    RulesSheet()
}
