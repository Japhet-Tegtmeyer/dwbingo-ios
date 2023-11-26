//
//  ChildCardView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import SwiftUI

struct ChildCardView: View {
    // App Storage to persist data
    @AppStorage("email") var email: String = "" // Email
    @AppStorage("name_prefix") var namePrefix: String = "" // Name prefix mr/mrs
    @AppStorage("first_name") var firstName: String = "" // First/Given name
    @AppStorage("last_name") var lastName: String = "" // Last/Family name
    @AppStorage("name_suffix") var nameSuffix: String = "" // Name suffix jr
    @AppStorage("user_id") var userId: String = "" // Apple user ID
    @AppStorage("cardid") var selectedCardId: Int? // Users card
    @AppStorage("childcardid") var childselectedCardId: Int? // Childs card
    @AppStorage("ChildName") var childName: String = "" // Childs first/given name
    @AppStorage("Cardresets") var resetCount: Int = 0 // Times reset button has been clicked
    @AppStorage("Cardresetschild") var resetCountC: Int = 0 // Times child card has been reset
    @AppStorage("isButtonD") var isButtonDisabled: Bool = false // Is the button disabled or not
    @AppStorage("IsButtonDC") var isButtonDisabledC: Bool = false // Is the child button disabled
    @AppStorage("agreed") var agreed: Bool = false // Has the person agreed to the terms
    
    // variables
    var bingocards: [Card] // Bingo cards is of type Card
    var editNameTip = EditNameTip() // Edit name tip
    var childTip = ChildTip() // Child tip
    var resetCardTip = ResetCardTip() // Reset card tip
    
    // State variables
    @State var selectedCard: Card { // Saves the card ID of the selected card
        didSet {
            selectedCardId = selectedCard.cardId
        }
    }
    @State var childselectedCard: Card { // Saves the card ID of the child selected card
        didSet {
            childselectedCardId = childselectedCard.cardId
        }
    }
    @State private var isSheetShowing: Bool = false // Is the child name sheet showing
    @State private var isSettingsSheetShowing: Bool = false // Is the settings sheet showing
    @State private var showAlert: Bool = false // Is the alert showing
    @State private var isAgreeSheet: Bool = false // Is the agreeing sheet showing
    @State private var needName: Bool = false // Is the first or last name empty
    @State private var isWeatherSheetShowing: Bool = false
    
    var body: some View {
        VStack {
            // MARK: Child card name
            Text("\(childName) \(lastName)")
                .font(.largeTitle)
                .bold()
                .onLongPressGesture {
                    isSheetShowing = true
                }
                .accessibilityLabel("Child name")
            
            // MARK: Child card image
            Image(childselectedCard.bcard)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400,
                       height: 400)
                .shadow(color: .gray.opacity(0.2), radius: 10)
                .accessibilityLabel("Child card")
            
            // MARK: Child card reset button
            HStack {
                if Date() < Calendar.current.date(from: DateComponents(year: 2024,
                                                                       month: 2,
                                                                       day: 17)) ?? Date() {
                    Button {
                        updateChildSelectedCard()
                        
                        resetCountC += 1
                        
                        if resetCountC >= 5 {
                            isButtonDisabledC = true
                            showAlert = true
                        }
                        
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.small)
                            .foregroundStyle(childselectedCard.color)
                            .bold()
                            .padding(11)
                            .padding(.horizontal, 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(childselectedCard.color,
                                            lineWidth: 2)
                            )
                            .padding()
                            .onAppear {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                            .accessibilityLabel("Button to refresh card")
                    }
                    .opacity(isButtonDisabledC ? 0.3 : 1)
                    .padding(.leading, -0)
                    .disabled(isButtonDisabledC)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Button Disabled"),
                              message: Text("You've reached the maximum number of resets"),
                              dismissButton: .default(Text("OK")))
                    }
                    .onTapGesture {
                        if isButtonDisabledC {
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                        }
                    }
                }
                
                // MARK: Child card share button
                let imagec = Image(childselectedCard.bcard)
                ShareLink(item: imagec,
                          message: Text("Bingo card for: \(childName)"),
                          preview: SharePreview("Bingo Card",
                                                image: imagec)) {
                    
                    Text("Share")
                        .foregroundStyle(childselectedCard.color)
                        .bold()
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(childselectedCard.color,
                                        lineWidth: 2)
                        )
                        .accessibilityLabel("Button to share child card")
                }
            }
            
            // MARK: Child card delete
            Menu("Delete") {
                Button {
                    childName = ""
                } label: {
                    Text("Delete Child Card")
                }
            }
            .foregroundStyle(.red)
            .padding(.bottom, 15)
            .padding(.top, -10)
            
        }
        .onAppear {
            if let storedChildCardId = childselectedCardId, let ccard = bingocards.first(where: { $0.cardId == storedChildCardId }) {
                childselectedCard = ccard
            } else {
                updateChildSelectedCard()
            }
        }
    }
    
    public func updateChildSelectedCard() {
        childselectedCard = bingocards.randomElement() ?? Card(bcard: "DisneyBingo",
                                                               cardId: 001,
                                                               color: .colorD1)
    }
}

#Preview {
    ChildCardView(bingocards: BingoCards().bingoCards,
                  selectedCard: Card(bcard: "Disaney",
                                     cardId: 001,
                                     color: .colorD1),
                  childselectedCard: Card(bcard: "D",
                                          cardId: 01,
                                          color: .colorD1))
}
