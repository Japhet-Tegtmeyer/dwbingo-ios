//
//  MainCardView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import SwiftUI
import TipKit
import CoreMotion

struct MainCardView: View {
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
    @AppStorage("cardColor") var cardColor: String = ""
    
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
    @AppStorage("Edit") var isEditing: Bool = false
    
    var body: some View {
        VStack {
            TipView(editNameTip,
                    arrowEdge: .bottom)
                .accessibilityLabel("Tip for editing name")
            
            TipView(childTip,
                    arrowEdge: .top)
                .accessibilityLabel("Tip for child card creation")
           
            // MARK: Main card name
            Text("\(firstName) \(lastName)")
                .font(.largeTitle)
                .bold()
                .onLongPressGesture {
                    needName = true
                    isEditing = true
                }
                .accessibilityLabel("Name")
            
            // MARK: Main card image
            Image(selectedCard.bcard)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400,
                       height: 400)
                .shadow(color: .gray.opacity(0.2), radius: 10)
                .accessibilityLabel("Main card")
                
            HStack {
                if Date() < Calendar.current.date(from: DateComponents(year: 2024,
                                                                       month: 2,
                                                                       day: 17)) ?? Date() {
                    Button {
                        updateSelectedCard()
                        
                        resetCount += 1
                        
                        if resetCount >= 5 {
                            isButtonDisabled = true
                            showAlert = true
                        }
                        
                        cardColor = "\(selectedCard.color)"
                        
                        UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
                    } label: {
                        Image(systemName: "arrow.clockwise")
                            .imageScale(.small)
                            .foregroundStyle(selectedCard.color)
                            .bold()
                            .padding(11)
                            .padding(.horizontal, 1)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(selectedCard.color,
                                            lineWidth: 2)
                            )
                            .padding()
                            .onAppear {
                                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                            }
                            .accessibilityLabel("Button to refresh main card")
                    }
                    .opacity(isButtonDisabled ? 0.3 : 1)
                    .disabled(isButtonDisabled)
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Button Disabled"),
                              message: Text("You've reached the maximum number of resets"),
                              dismissButton: .default(Text("OK")))
                    }
                    .onTapGesture {
                        if isButtonDisabled {
                            let generator = UINotificationFeedbackGenerator()
                            generator.notificationOccurred(.error)
                        }
                    }
                }
                
                // MARK: Main card image share
                let image = Image(selectedCard.bcard)
                
                ShareLink(item: image,
                          message: Text("Bingo card for: \(firstName)"),
                          preview: SharePreview("Bingo Card",
                                                image: image)) {
                    Text("Share")
                        .foregroundStyle(selectedCard.color)
                        .bold()
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCard.color,
                                        lineWidth: 2)
                        )
                        .accessibilityLabel("Button to share main card")
                }
                                                .padding(8)
            }
            .padding(.bottom, 30)
            
            TipView(resetCardTip, arrowEdge: .top)
        }
        .onAppear {
            if let storedCardId = selectedCardId, let card = bingocards.first(where: { $0.cardId == storedCardId }) {
                selectedCard = card
            } else {
                updateSelectedCard()
            }
        }
        .sheet(isPresented: $needName) {
            NeedNameSheet()
                .interactiveDismissDisabled()
        }
        
    }
    
    public func updateSelectedCard() {
        selectedCard = bingocards.randomElement() ?? Card(bcard: "DisneyBingo",
                                                          cardId: 001,
                                                          color: .colorD1)
    }
    
}

#Preview {
    MainCardView(bingocards: BingoCards().bingoCards, 
                 selectedCard: Card(bcard: "Disaney",
                                    cardId: 001, color: .colorD1),
                 childselectedCard: Card(bcard: "D",
                                         cardId: 01,
                                         color: .colorD1))
}
