import SwiftUI

struct AnalysisView: View {
    @EnvironmentObject var glowViewModel: GlowGirlViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedPage = 0
    @State private var sparkleAnimation = false
    @State private var floatingSparkles = Array(0..<15).map { _ in FloatingSparkle() }
    
    var body: some View {
        ZStack {
            // ICONIC gradient background - pink to purple to orange
            LinearGradient(
                colors: [
                    Color.pink.opacity(0.3),
                    Color.purple.opacity(0.4), 
                    Color.orange.opacity(0.2)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // Floating sparkles background
            ForEach(floatingSparkles.indices, id: \.self) { index in
                FloatingSparkleView(sparkle: floatingSparkles[index])
            }
            
            VStack(spacing: 0) {
                // ICONIC header with animated sparkle divider
                VStack(spacing: 15) {
                    HStack {
                        Button("close") {
                            dismiss()
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.8))
                        
                        Spacer()
                        
                        Text(selectedPage == 0 ? "my story ✨" : "glow up 💅")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple, .orange],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Spacer()
                        
                        Button("new tea") {
                            glowViewModel.resetAnalysis()
                            dismiss()
                        }
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.pink.opacity(0.8))
                    }
                    
                    // Animated sparkle divider
                    HStack(spacing: 8) {
                        ForEach(0..<7, id: \.self) { index in
                            Text("✨")
                                .font(.system(size: 12))
                                .opacity(sparkleAnimation ? 1.0 : 0.3)
                                .scaleEffect(sparkleAnimation ? 1.2 : 0.8)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: true)
                                    .delay(Double(index) * 0.2),
                                    value: sparkleAnimation
                                )
                        }
                    }
                }
                .padding(.horizontal, 25)
                .padding(.top, 15)
                .padding(.bottom, 20)
                
                // Page content
                TabView(selection: $selectedPage) {
                    // Page 1: My Story (Life Analysis)
                    MyStoryPage()
                        .tag(0)
                    
                    // Page 2: Glow Up Plan
                    GlowUpPage()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                // ICONIC bottom navigation with hearts and sparkles
                HStack(spacing: 80) {
                    VStack(spacing: 6) {
                        Button(action: { 
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedPage = 0 
                            }
                        }) {
                            VStack(spacing: 4) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: selectedPage == 0 ? [.pink, .purple] : [.pink.opacity(0.2), .purple.opacity(0.2)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 45, height: 45)
                                        .scaleEffect(selectedPage == 0 ? 1.1 : 1.0)
                                    
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(selectedPage == 0 ? .white : .pink.opacity(0.6))
                                }
                                
                                Text("my story")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(selectedPage == 0 ? .pink : .pink.opacity(0.5))
                            }
                        }
                    }
                    
                    VStack(spacing: 6) {
                        Button(action: { 
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                selectedPage = 1 
                            }
                        }) {
                            VStack(spacing: 4) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: selectedPage == 1 ? [.purple, .orange] : [.purple.opacity(0.2), .orange.opacity(0.2)],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 45, height: 45)
                                        .scaleEffect(selectedPage == 1 ? 1.1 : 1.0)
                                    
                                    Image(systemName: "sparkles")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(selectedPage == 1 ? .white : .purple.opacity(0.6))
                                }
                                
                                Text("glow up")
                                    .font(.system(size: 12, weight: .semibold))
                                    .foregroundColor(selectedPage == 1 ? .purple : .purple.opacity(0.5))
                            }
                        }
                    }
                }
                .padding(.bottom, 50)
            }
        }
        .onAppear {
            sparkleAnimation = true
        }
    }
}

// MARK: - Page 1: My Story (Life Analysis) - ABSOLUTELY ICONIC
struct MyStoryPage: View {
    @State private var emotionallyAvailable = false
    @State private var pulseAnimation = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 25) {
                // ur current main character era section
                MainCharacterEraCard()
                
                // ur tribe of besties
                UrTribeBestiesCard()
                
                // ur love story timeline - ICONIC
                LoveStoryTimelineCard()
                
                // ur next chapter energy with toggle
                VStack(spacing: 20) {
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("ur next chapter energy 💫")
                                .font(.system(size: 20, weight: .bold, design: .rounded))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.pink, .purple],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                            
                            Text("ready for emotionally available vibes?")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.purple.opacity(0.8))
                        }
                        
                        Spacer()
                        
                        Toggle("", isOn: $emotionallyAvailable)
                            .tint(.pink)
                            .scaleEffect(1.3)
                            .animation(.spring(response: 0.6), value: emotionallyAvailable)
                    }
                    
                    // Show content based on toggle
                    if emotionallyAvailable {
                        DatingRecommendationsCard()
                            .transition(.asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .scale.combined(with: .opacity)
                            ))
                    } else {
                        HealingEraCard()
                            .transition(.asymmetric(
                                insertion: .scale.combined(with: .opacity),
                                removal: .scale.combined(with: .opacity)
                            ))
                    }
                }
                .padding(25)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(
                            LinearGradient(
                                colors: [Color.white.opacity(0.9), Color.pink.opacity(0.05)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .shadow(color: .pink.opacity(0.2), radius: 15, x: 0, y: 8)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(
                            LinearGradient(
                                colors: [.pink.opacity(0.3), .purple.opacity(0.2)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 1
                        )
                )
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
        .animation(.spring(response: 0.8, dampingFraction: 0.8), value: emotionallyAvailable)
    }
}

// MARK: - Page 2: Glow Up Plan - REVOLUTIONARY
struct GlowUpPage: View {
    @State private var rashiAnimation = false
    @State private var sparkleOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // ur life story most similar to iconic character
                IconicCharacterCard()
                
                // Indian rashi predictions - ICONIC
                VStack(spacing: 20) {
                    Text("rashi predictions bestie ✨")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .pink],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    EnhancedIndianRashiCard()
                }
                
                // today's main character fit 💅 - MAIN FOCUS
                VStack(spacing: 20) {
                    HStack {
                        Text("today's main character fit 💅")
                            .font(.system(size: 22, weight: .bold, design: .rounded))
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                        
                        Spacer()
                        
                        Text("✨")
                            .font(.system(size: 20))
                            .offset(x: sparkleOffset)
                            .animation(
                                .easeInOut(duration: 2.0)
                                .repeatForever(autoreverses: true),
                                value: sparkleOffset
                            )
                    }
                    
                    // Outfit cards with images
                    VStack(spacing: 20) {
                        IconicOutfitCard(
                            category: "power babe energy 💼",
                            outfit: "black blazer + gold jewelry + slicked back hair",
                            makeup: "bold winged liner + nude gloss",
                            earrings: "gold hoops that hit different",
                            vibe: "ceo of everything",
                            colors: [.purple, .pink]
                        )
                        
                        IconicOutfitCard(
                            category: "date night goddess ✨",
                            outfit: "silk slip dress + strappy heels + leather jacket",
                            makeup: "smoky eyes + red lips that stop traffic",
                            earrings: "statement pearls because ur classic",
                            vibe: "main character energy",
                            colors: [.pink, .orange]
                        )
                        
                        IconicOutfitCard(
                            category: "casual but make it iconic 🦋",
                            outfit: "crop top + high waisted jeans + white sneakers",
                            makeup: "dewy skin + glossy lips + fluffy brows",
                            earrings: "layered gold studs for that effortless vibe",
                            vibe: "off duty model",
                            colors: [.orange, .purple]
                        )
                    }
                }
                
                // what the stars see for u ⭐
                FutureTimelinePredictionsCard()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 15)
        }
        .onAppear {
            rashiAnimation = true
            sparkleOffset = 10
        }
    }
}

// MARK: - ICONIC Supporting Views

// Main Character Era Card
struct MainCharacterEraCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur current main character era 👑")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                HeartbreakBestieCard()
                SingleQueenCard()
                GlowUpEraCard()
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.pink.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .pink.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct HeartbreakBestieCard: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("💔")
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("the heartbreak bestie")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.pink)
                
                Text("healing but make it iconic")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
            }
            
            Spacer()
            
            Text("active")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(.pink)
                )
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.pink.opacity(0.08))
                .stroke(Color.pink.opacity(0.2), lineWidth: 1)
        )
    }
}

struct SingleQueenCard: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("👑")
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("the single queen")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.purple)
                
                Text("two years strong and glowing")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
            }
            
            Spacer()
            
            Text("thriving")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(.purple)
                )
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.purple.opacity(0.08))
                .stroke(Color.purple.opacity(0.2), lineWidth: 1)
        )
    }
}

struct GlowUpEraCard: View {
    var body: some View {
        HStack(spacing: 15) {
            Text("✨")
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text("the glow up goddess")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.orange)
                
                Text("serving looks and confidence")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.orange.opacity(0.8))
            }
            
            Spacer()
            
            Text("iconic")
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .fill(.orange)
                )
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.orange.opacity(0.08))
                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
        )
    }
}

// ur tribe of besties
struct UrTribeBestiesCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur tribe of besties 💕")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                BestieRecommendationCard(
                    name: "priya",
                    vibe: "healing era but serving looks",
                    situation: "fresh out of a 3 year relationship",
                    color: .pink
                )
                
                BestieRecommendationCard(
                    name: "maya",
                    vibe: "phoenix rising from heartbreak",
                    situation: "single for 6 months and glowing",
                    color: .purple
                )
                
                BestieRecommendationCard(
                    name: "aria",
                    vibe: "independent queen energy",
                    situation: "choosing herself for once",
                    color: .orange
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct BestieRecommendationCard: View {
    let name: String
    let vibe: String
    let situation: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(
                    LinearGradient(
                        colors: [color, color.opacity(0.6)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: 50, height: 50)
                .overlay(
                    Text(name.prefix(1).uppercased())
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(color)
                
                Text(vibe)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                
                Text(situation)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            
            Spacer()
            
            Button("connect") {
                // Connect action
            }
            .font(.system(size: 14, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule()
                    .fill(
                        LinearGradient(
                            colors: [color, color.opacity(0.8)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
            )
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.9))
                .stroke(color.opacity(0.2), lineWidth: 1)
                .shadow(color: color.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

// Love Story Timeline - ICONIC
struct LoveStoryTimelineCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur love story timeline 💕")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 18) {
                TimelineEvent(
                    name: "raghav",
                    period: "2020-2021",
                    vibe: "first love energy",
                    color: .pink,
                    position: .left
                )
                
                TimelineEvent(
                    name: "matt burdulis",
                    period: "2021-2022",
                    vibe: "adventure chapter",
                    color: .purple,
                    position: .right
                )
                
                TimelineEvent(
                    name: "aditya mehra",
                    period: "2022",
                    vibe: "learning experience",
                    color: .orange,
                    position: .left
                )
                
                TimelineEvent(
                    name: "teg singh",
                    period: "2023",
                    vibe: "brief connection",
                    color: .pink,
                    position: .right
                )
                
                TimelineEvent(
                    name: "aditya mehra (again)",
                    period: "early 2024",
                    vibe: "second chances don't always work",
                    color: .purple,
                    position: .left
                )
                
                CurrentSingleStage()
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.orange.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .orange.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct TimelineEvent: View {
    let name: String
    let period: String
    let vibe: String
    let color: Color
    let position: TimelinePosition
    
    enum TimelinePosition {
        case left, right
    }
    
    var body: some View {
        HStack {
            if position == .right {
                Spacer()
            }
            
            VStack(spacing: 0) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 16, height: 16)
                
                Rectangle()
                    .fill(color.opacity(0.3))
                    .frame(width: 2, height: 40)
            }
            
            VStack(alignment: position == .left ? .leading : .trailing, spacing: 6) {
                Text(name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(color)
                
                Text(period)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                
                Text(vibe)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            .padding(.horizontal, 15)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(color.opacity(0.1))
                    .stroke(color.opacity(0.3), lineWidth: 1)
            )
            
            if position == .left {
                Spacer()
            }
        }
    }
}

struct CurrentSingleStage: View {
    @State private var glowAnimation = false
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                VStack(spacing: 0) {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [.pink, .purple, .orange],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 20, height: 20)
                        .scaleEffect(glowAnimation ? 1.2 : 1.0)
                        .animation(
                            .easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true),
                            value: glowAnimation
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("ur single era 👑")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.pink, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    
                    Text("feb 2024 - july 2025 (and counting)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.purple.opacity(0.8))
                    
                    Text("main character energy unlocked ✨")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.purple.opacity(0.6))
                }
                
                Spacer()
            }
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.9), Color.pink.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [.pink.opacity(0.4), .purple.opacity(0.3)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .shadow(color: .pink.opacity(0.2), radius: 10, x: 0, y: 5)
        )
        .onAppear {
            glowAnimation = true
        }
    }
}

// Dating Recommendations Card
struct DatingRecommendationsCard: View {
    var body: some View {
        VStack(spacing: 18) {
            Text("dating recommendations ✨")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.pink)
            
            VStack(spacing: 12) {
                DatingRecommendation(
                    name: "alex",
                    age: "26",
                    vibe: "emotionally available and ready",
                    match: "89%",
                    color: .pink
                )
                
                DatingRecommendation(
                    name: "jordan",
                    age: "28",
                    vibe: "mature energy, good communication",
                    match: "92%",
                    color: .purple
                )
                
                DatingRecommendation(
                    name: "riley",
                    age: "25",
                    vibe: "adventurous but grounded",
                    match: "85%",
                    color: .orange
                )
            }
        }
    }
}

struct DatingRecommendation: View {
    let name: String
    let age: String
    let vibe: String
    let match: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 45, height: 45)
                .overlay(
                    Text(name.prefix(1).uppercased())
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(color)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(name)
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(color)
                    
                    Text(age)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.purple.opacity(0.7))
                }
                
                Text(vibe)
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
            
            Spacer()
            
            VStack(spacing: 4) {
                Text(match)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                
                Text("match")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundColor(.purple.opacity(0.6))
            }
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white.opacity(0.8))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Healing Era Card
struct HealingEraCard: View {
    @State private var sparkleAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("healing era activated 🌸")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
                
                Text("✨")
                    .font(.system(size: 18))
                    .scaleEffect(sparkleAnimation ? 1.3 : 1.0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .repeatForever(autoreverses: true),
                        value: sparkleAnimation
                    )
            }
            
            VStack(spacing: 15) {
                HealingActivity(
                    activity: "daily affirmations",
                    description: "reminding urself ur a queen",
                    emoji: "👑",
                    color: .pink
                )
                
                HealingActivity(
                    activity: "self care sundays",
                    description: "face masks and good vibes only",
                    emoji: "🧴",
                    color: .purple
                )
                
                HealingActivity(
                    activity: "journaling ur growth",
                    description: "tracking ur main character moments",
                    emoji: "📖",
                    color: .orange
                )
            }
        }
        .onAppear {
            sparkleAnimation = true
        }
    }
}

struct HealingActivity: View {
    let activity: String
    let description: String
    let emoji: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 24))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(activity)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(color)
                
                Text(description)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.7))
            }
            
            Spacer()
        }
        .padding(15)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.1))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Iconic Character Card
struct IconicCharacterCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("ur life is giving... 🎬")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .orange],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                Text("naina talwar from yeh jawaani hai deewani")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.purple)
                    .multilineTextAlignment(.center)
                
                Text("the quiet girl who found her confidence and started living life on her own terms 🦋")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                    .multilineTextAlignment(.center)
                    .lineSpacing(4)
                
                VStack(spacing: 8) {
                    CharacterTrait(trait: "transformed from shy to confident", emoji: "🌟")
                    CharacterTrait(trait: "learned to prioritize herself", emoji: "💝")
                    CharacterTrait(trait: "glowed up inside and out", emoji: "✨")
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: .purple.opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct CharacterTrait: View {
    let trait: String
    let emoji: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.system(size: 16))
            
            Text(trait)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.purple.opacity(0.8))
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.purple.opacity(0.05))
                .stroke(Color.purple.opacity(0.15), lineWidth: 1)
        )
    }
}

// Enhanced Indian Rashi Card
struct EnhancedIndianRashiCard: View {
    @State private var glowAnimation = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("अश्विनी (ashwini)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.orange)
                    
                    Text("horse energy - fast, free, unstoppable")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.orange.opacity(0.8))
                }
                
                Spacer()
                
                Text("🐎")
                    .font(.system(size: 32))
                    .scaleEffect(glowAnimation ? 1.1 : 1.0)
                    .animation(
                        .easeInOut(duration: 2.0)
                        .repeatForever(autoreverses: true),
                        value: glowAnimation
                    )
            }
            
            VStack(spacing: 15) {
                Text("ashwini energy is calling for a complete rebrand bestie ✨")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.orange)
                    .multilineTextAlignment(.center)
                
                VStack(spacing: 10) {
                    RashiPrediction(
                        prediction: "new beginnings are ur specialty",
                        emoji: "🌅"
                    )
                    
                    RashiPrediction(
                        prediction: "leadership energy is activating",
                        emoji: "👑"
                    )
                    
                    RashiPrediction(
                        prediction: "speed up ur glow up timeline",
                        emoji: "⚡"
                    )
                }
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.orange.opacity(0.1)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [.orange.opacity(0.4), .orange.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .shadow(color: .orange.opacity(0.2), radius: 15, x: 0, y: 8)
        )
        .onAppear {
            glowAnimation = true
        }
    }
}

struct RashiPrediction: View {
    let prediction: String
    let emoji: String
    
    var body: some View {
        HStack(spacing: 12) {
            Text(emoji)
                .font(.system(size: 16))
            
            Text(prediction)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.orange.opacity(0.8))
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.orange.opacity(0.08))
                .stroke(Color.orange.opacity(0.2), lineWidth: 1)
        )
    }
}

// Iconic Outfit Card with images and makeup
struct IconicOutfitCard: View {
    let category: String
    let outfit: String
    let makeup: String
    let earrings: String
    let vibe: String
    let colors: [Color]
    
    var body: some View {
        VStack(spacing: 18) {
            HStack {
                Text(category)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundStyle(
                        LinearGradient(
                            colors: colors,
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Spacer()
                
                Text(vibe)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: colors,
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            
            VStack(spacing: 12) {
                OutfitDetail(
                    title: "fit",
                    detail: outfit,
                    emoji: "👗",
                    color: colors[0]
                )
                
                OutfitDetail(
                    title: "makeup",
                    detail: makeup,
                    emoji: "💄",
                    color: colors[1]
                )
                
                OutfitDetail(
                    title: "earrings",
                    detail: earrings,
                    emoji: "💎",
                    color: colors[0]
                )
            }
        }
        .padding(22)
        .background(
            RoundedRectangle(cornerRadius: 22)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), colors[0].opacity(0.05)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [colors[0].opacity(0.3), colors[1].opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1.5
                )
                .shadow(color: colors[0].opacity(0.15), radius: 12, x: 0, y: 6)
        )
    }
}

struct OutfitDetail: View {
    let title: String
    let detail: String
    let emoji: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 15) {
            Text(emoji)
                .font(.system(size: 20))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(color)
                
                Text(detail)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.purple.opacity(0.8))
                    .lineLimit(2)
            }
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(color.opacity(0.08))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Future Timeline Predictions
struct FutureTimelinePredictionsCard: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("what the stars see for u ⭐")
                .font(.system(size: 20, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.purple, .pink],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
            
            VStack(spacing: 15) {
                FuturePredictionRow(
                    timeframe: "2 weeks",
                    prediction: "someone's gonna notice ur main character energy and slide into ur dms 👀",
                    color: .pink,
                    confidence: "94%"
                )
                
                FuturePredictionRow(
                    timeframe: "1 month",
                    prediction: "ur confidence hits different - people can't stop staring when u walk in ✨",
                    color: .purple,
                    confidence: "87%"
                )
                
                FuturePredictionRow(
                    timeframe: "3 months",
                    prediction: "new romantic energy enters - they're gonna be obsessed with ur glow up bestie 💕",
                    color: .orange,
                    confidence: "91%"
                )
                
                FuturePredictionRow(
                    timeframe: "6 months",
                    prediction: "ur whole life transforms - career, love, friendships all leveling up together 🚀",
                    color: .pink,
                    confidence: "89%"
                )
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    LinearGradient(
                        colors: [Color.white.opacity(0.95), Color.purple.opacity(0.08)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .stroke(
                    LinearGradient(
                        colors: [.purple.opacity(0.3), .pink.opacity(0.2)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
                .shadow(color: .purple.opacity(0.15), radius: 15, x: 0, y: 8)
        )
    }
}

struct FuturePredictionRow: View {
    let timeframe: String
    let prediction: String
    let color: Color
    let confidence: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            VStack(spacing: 6) {
                Text(timeframe)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(color)
                    )
                
                Text(confidence)
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(color)
            }
            
            Text(prediction)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.purple.opacity(0.8))
                .lineLimit(nil)
                .lineSpacing(3)
            
            Spacer()
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 18)
                .fill(color.opacity(0.05))
                .stroke(color.opacity(0.2), lineWidth: 1)
        )
    }
}

// Floating Sparkles
struct FloatingSparkle {
    var x: CGFloat = CGFloat.random(in: -50...400)
    var y: CGFloat = CGFloat.random(in: 0...800)
    var scale: CGFloat = CGFloat.random(in: 0.5...1.2)
    var opacity: Double = Double.random(in: 0.3...0.8)
    var speed: Double = Double.random(in: 3...8)
}

struct FloatingSparkleView: View {
    let sparkle: FloatingSparkle
    @State private var animationOffset: CGFloat = 0
    @State private var animationOpacity: Double = 0.3
    
    var body: some View {
        Text("✨")
            .font(.system(size: 12))
            .scaleEffect(sparkle.scale)
            .opacity(animationOpacity)
            .position(x: sparkle.x, y: sparkle.y + animationOffset)
            .onAppear {
                withAnimation(
                    .linear(duration: sparkle.speed)
                    .repeatForever(autoreverses: false)
                ) {
                    animationOffset = -900
                }
                
                withAnimation(
                    .easeInOut(duration: 2.0)
                    .repeatForever(autoreverses: true)
                ) {
                    animationOpacity = sparkle.opacity
                }
            }
    }
}



#Preview {
    AnalysisView()
        .environmentObject(GlowGirlViewModel())
}
