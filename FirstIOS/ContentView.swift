import SwiftUI

struct ContentView: View {
    
    @State private var cards = Array(1...5)
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {           // spacing: 0 ist hier wichtig
                Spacer()                   // ← Schiebt alles nach unten (Mitte + Buttons)
                
                // Deine Karten
                ZStack {
                    ForEach(cards, id: \.self) { card in
                        CardView(
                            number: card,
                            onRemove: {
                                removeCard(card)
                            }
                        )
                    }
                }
                .frame(maxHeight: 450)     // Optional: begrenzt die Höhe der Karten-Zone
                
                Spacer()                   // ← Zweiter Spacer für echte vertikale Zentrierung
                
                // 🔽 BUTTONS
                HStack(spacing: 40) {
                    Button(action: { swipeLeft() }) {
                        Image(systemName: "trash.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { reviewCard() }) {
                        Image(systemName: "eye.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.yellow)
                            .clipShape(Circle())
                    }
                    
                    Button(action: { swipeRight() }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
    
    // MARK: - Aktionen
    
    func removeCard(_ card: Int) {
        withAnimation {
            cards.removeAll { $0 == card }
        }
    }
    
    func topCard() -> Int? {
        return cards.last
    }
    
    func swipeLeft() {
        if let card = topCard() {
            removeCard(card)
        }
    }
    
    func swipeRight() {
        if let card = topCard() {
            removeCard(card)
        }
    }
    
    func reviewCard() {
        if let card = topCard() {
            print("Review Karte \(card)")
        }
    }
}

struct CardView: View {
    
    let number: Int
    var onRemove: () -> Void
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        ZStack {
            
            // Hintergrund-Farbe (rot oder grün je nach Swipe)
            RoundedRectangle(cornerRadius: 20)
                .fill(backgroundColor())
            
            Text("Karte \(number)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
        .frame(height: 400)
        .offset(x: offset.width, y: offset.height)
        .rotationEffect(.degrees(Double(offset.width / 10)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    handleSwipe()
                }
        )
        .animation(.spring(), value: offset)
    }
    
    func backgroundColor() -> Color {
        if offset.width > 0 {
            return Color.green.opacity(0.7)
        } else if offset.width < 0 {
            return Color.red.opacity(0.7)
        } else {
            return Color.gray
        }
    }
    
    func handleSwipe() {
        if offset.width > 150 {
            // Swipe nach rechts
            offset = CGSize(width: 1000, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                onRemove()
            }
        } else if offset.width < -150 {
            // Swipe nach links
            offset = CGSize(width: -1000, height: 0)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                onRemove()
            }
        } else {
            // zurückspringen
            offset = .zero
        }
    }
}

#Preview {
    ContentView()
}
