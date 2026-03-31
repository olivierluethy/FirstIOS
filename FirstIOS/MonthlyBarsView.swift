import SwiftUI

struct MonthsBarFullWidthView: View {
    let months = Calendar.current.monthSymbols
    let currentMonthIndex = Calendar.current.component(.month, from: Date()) - 1
    let currentYear = Calendar.current.component(.year, from: Date()) % 100
    let currentDay = Calendar.current.component(.day, from: Date())
   
    // Farben für die Monate
    let monthColors: [Color] = [
        .red, .orange, .yellow, .green, .mint, .teal, .blue, .indigo, .purple, .pink, .brown, .gray
    ]
   
    // Hilfsfunktion: Tage pro Monat
    func daysInMonth(month: Int, year: Int) -> Int {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = year
        components.month = month
        let date = calendar.date(from: components)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
   
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
               
                // MARK: On This Day
                HStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("on this day")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                    }
                    
                    ZStack {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 52, weight: .black))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.yellow, .orange, .red, .orange],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .shadow(color: .yellow.opacity(0.9), radius: 12, x: 0, y: 4)
                            .shadow(color: .red.opacity(0.6), radius: 8, x: 0, y: 2)
                       
                        // Zahl in der Flamme
                        Text("\(currentDay)")
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .foregroundStyle(.white)
                            .shadow(color: .black.opacity(0.7), radius: 2)
                    }
                }
                .frame(maxWidth: .infinity, minHeight: 140, alignment: .leading)
                .padding(.leading, 20)
                .background(
                    LinearGradient(
                        colors: [Color.purple, Color.indigo, Color.purple.opacity(0.8)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
               
                // MARK: Random
                HStack {
                    Text("random")
                        .bold()
                        .font(.system(size: 34, weight: .heavy, design: .rounded))
                    Image(systemName: "shuffle")
                        .font(.system(size: 34, weight: .heavy))
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, minHeight: 140)
                .background(
                    LinearGradient(
                        colors: [.purple, .blue],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
               
                // MARK: Monate
                ForEach(months.indices, id: \.self) { index in
                    HStack {
                        Text("\(months[index].prefix(3).uppercased()) - '\(daysInMonth(month: index + 1, year: Calendar.current.component(.year, from: Date())))")
                            .bold()
                            .foregroundColor(.white)
                            .font(.system(size: 34, weight: .heavy, design: .rounded))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                    }
                    .frame(maxWidth: .infinity, minHeight: 140)
                    .background(monthColors[index])
                }
            }
        }
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct MonthsBarFullWidthView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MonthsBarFullWidthView()
        }
    }
}
