//
//  ContentView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/12/23.
//

// Imports
import SwiftUI
import TipKit // Import TipKit framework for displaying tips

// MARK: ContentView
struct MainTabView: View {
    @ObservedObject var weatherManager = WeatherManager()
    @ObservedObject var motionManager = MotionManager()
    
    // App Storage to persist data
    @AppStorage("name_prefix") var namePrefix: String = "" // Name prefix mr/mrs
    @AppStorage("first_name") var firstName: String = "" // First/Given name
    @AppStorage("last_name") var lastName: String = "" // Last/Family name
    @AppStorage("name_suffix") var nameSuffix: String = "" // Name suffix (jr)
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
    @State private var isChildNameSheetShowing: Bool = false // Is the child name sheet showing
    @State private var isSettingsSheetShowing: Bool = false // Is the settings sheet showing
    @State private var showAlert: Bool = false // Is the alert showing
    @State private var isAgreeSheet: Bool = false // Is the agreeing sheet showing
    @State private var needName: Bool = false // Is the first or last name empty
    @State private var isWeatherSheetShowing: Bool = false // Is the weather sheet showing
    @State var badgeManager = AppAlertBadgeManager(application: UIApplication.shared)
    
    var body: some View {
        NavigationStack { // NavigationStack for nav title
            VStack {
                TabView {
                    MainCardView(bingocards: BingoCards().bingoCards,
                                 selectedCard: Card(bcard: "Disaney",
                                                    cardId: 001,
                                                    color: .colorD1),
                                 childselectedCard: Card(bcard: "D",
                                                         cardId: 01,
                                                         color: .colorD1)) // Main card view
                    .offset(x: motionManager.roll * 10, y: motionManager.pitch * 10)
                    
                    if !childName.isEmpty { // If the child name is NOT empty
                        ChildCardView(bingocards: BingoCards().bingoCards,
                                      selectedCard: Card(bcard: "Disaney",
                                                         cardId: 001,
                                                         color: .colorD1),
                                      childselectedCard: Card(bcard: "D",
                                                              cardId: 01,
                                                              color: .colorD1)) // Child card view
                        .offset(x: motionManager.roll * 10, y: motionManager.pitch * 10)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .navigationBarBackButtonHidden(true)
                .task { // MARK: Task
                    try? Tips.configure([
                        .displayFrequency(.daily),
                        .datastoreLocation(.applicationDefault)
                    ])
                }
                .onAppear { // MARK: On Appear
                    if !agreed {
                        isAgreeSheet = true
                    }
                    
                    if firstName.isEmpty || lastName.isEmpty {
                        needName = true
                    }
                }
                .toolbar { // MARK: Toolbar
                    ToolbarItem(placement: .topBarTrailing) {
                        if childName.isEmpty {
                            Button {
                                isChildNameSheetShowing = true
                                UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            } label: {
                                Image(systemName: "figure.and.child.holdinghands")
                                    .imageScale(.small)
                                    .padding(9)
                                    .padding(.horizontal, 1)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(.purple,
                                                    lineWidth: 2)
                                    )
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isSettingsSheetShowing = true
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .imageScale(.small)
                                .padding(10)
                                .padding(.horizontal, 1)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.purple,
                                                lineWidth: 2)
                                )
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image(systemName: "\(weatherManager.symbol).fill")
                                .task {
                                    await weatherManager.getWeather()
                                }
                            
                            Text("\(weatherManager.formattedTemp)ºF")
                                .font(.caption)
                                .bold()
                        }
                        .foregroundStyle(.purple)
                        .onLongPressGesture {
                            isWeatherSheetShowing = true
                        }
                    }
                }
                .navigationTitle("Cards")
                .navigationBarTitleDisplayMode(.inline) // How the nav title is displayed (.inline makes it small and centered)
                .sheet(isPresented: $isChildNameSheetShowing) { // MARK: Sheets
                    ChildCardSheet()
                }
                .sheet(isPresented: $isSettingsSheetShowing) {
                    SettingsSheet()
                }
                .sheet(isPresented: $isAgreeSheet) {
                    RulesSheet()
                        .interactiveDismissDisabled()
                }
                .sheet(isPresented: $needName) {
                    NeedNameSheet()
                        .interactiveDismissDisabled()
                }
                .onAppear {
                    badgeManager.resetAlertBadge()
                    motionManager.startMonitoringMotionUpdates()
                    
                    Task {
                        await weatherManager.getWeather()
                    }
                }
                HStack {
                    Text(" Weather •")
                    Link("Legal", destination: URL(string: "https://weatherkit.apple.com/legal-attribution.html")!)
                        .padding(.leading, -5)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .bold()
                .font(.caption)
            }
        }
    }
}

// Preview
#Preview {
    MainTabView(bingocards: BingoCards().bingoCards,
                selectedCard: Card(bcard: "Disaney",
                                   cardId: 001, color: .colorD1),
                childselectedCard: Card(bcard: "D",
                                        cardId: 01,
                                        color: .colorD1))
}
