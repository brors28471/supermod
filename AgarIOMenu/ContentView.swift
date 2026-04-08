import SwiftUI
import WebKit

struct ContentView: View {
    @State private var selectedMenu: String? = nil
    @State private var showMenu = false
    
    var body: some View {
        ZStack {
            // Agar.io WebView
            WebViewContainer()
                .ignoresSafeArea()
            
            // Menu button (floating)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showMenu = true }) {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.cyan)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                    }
                    .padding(20)
                }
            }
            
            // Menu overlay
            if showMenu {
                Color.black.opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showMenu = false
                    }
                
                if let selected = selectedMenu {
                    DetailView(menuItem: selected, showMenu: $showMenu, selectedMenu: $selectedMenu)
                } else {
                    MainMenuView(selectedMenu: $selectedMenu, showMenu: $showMenu)
                }
            }
        }
    }
}

struct WebViewContainer: UIViewRepresentable {
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let url = URL(string: "https://agar.io")!
        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

struct MainMenuView: View {
    @Binding var selectedMenu: String?
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("@dtje029")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {}) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
            .cornerRadius(12, corners: [.topLeft, .topRight])
            
            VStack(spacing: 0) {
                MenuRow(
                    title: "Gameplay",
                    icon: nil,
                    action: {
                        selectedMenu = "Gameplay"
                        showMenu = false
                    }
                )
                
                MenuRow(
                    title: "Zoom",
                    icon: Circle()
                        .fill(Color.red)
                        .frame(width: 20, height: 20),
                    action: {
                        selectedMenu = "Zoom"
                        showMenu = false
                    }
                )
                
                MenuRow(
                    title: "Macro",
                    icon: nil,
                    action: {
                        selectedMenu = "Macro"
                        showMenu = false
                    }
                )
                
                MenuRow(
                    title: "Mastersplit",
                    icon: Circle()
                        .fill(Color.purple)
                        .frame(width: 20, height: 20),
                    action: {
                        selectedMenu = "Mastersplit"
                        showMenu = false
                    }
                )
                
                MenuRow(
                    title: "Map",
                    icon: Circle()
                        .fill(Color.green)
                        .frame(width: 20, height: 20),
                    action: {
                        selectedMenu = "Map"
                        showMenu = false
                    }
                )
            }
            .background(Color(red: 0.25, green: 0.25, blue: 0.25))
            .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
            .padding()
            
            Spacer()
        }
    }
}

struct MenuRow: View {
    let title: String
    let icon: AnyView?
    let action: () -> Void
    
    var body: some View {
        HStack {
            if let icon = icon {
                icon
                    .padding(.leading, 16)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.white)
                .padding(.trailing, 16)
        }
        .frame(height: 50)
        .background(Color(red: 0.25, green: 0.25, blue: 0.25))
        .onTapGesture(perform: action)
    }
}

struct DetailView: View {
    let menuItem: String
    @Binding var showMenu: Bool
    @Binding var selectedMenu: String?
    @State private var selectedTab = 0
    
    var tabs: [String] {
        switch menuItem {
        case "Gameplay":
            return ["Speed", "Behavior", "Visual"]
        case "Zoom":
            return ["Level", "Smooth", "Auto"]
        case "Macro":
            return ["Split", "Feed", "Eject"]
        case "Mastersplit":
            return ["Mode", "Speed", "Advanced"]
        case "Map":
            return ["Style", "Size", "Opacity"]
        default:
            return ["Settings"]
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { selectedMenu = nil }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 16, weight: .semibold))
                        Text(menuItem)
                    }
                    .foregroundColor(.white)
                }
                
                Spacer()
                
                Button(action: { 
                    selectedMenu = nil
                    showMenu = false 
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(Color(red: 0.2, green: 0.2, blue: 0.2))
            
            Picker("", selection: $selectedTab) {
                ForEach(0..<tabs.count, id: \.self) { index in
                    Text(tabs[index])
                        .tag(index)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(Color(red: 0.25, green: 0.25, blue: 0.25))
            
            TabContentView(menuItem: menuItem, tabIndex: selectedTab)
            
            Spacer()
        }
        .background(Color(red: 0.15, green: 0.15, blue: 0.15))
    }
}

struct TabContentView: View {
    let menuItem: String
    let tabIndex: Int
    
    var settings: [(String, String)] {
        switch menuItem {
        case "Gameplay":
            switch tabIndex {
            case 0: // Speed
                return [
                    ("Movement Speed", "1.2x"),
                    ("Acceleration", "0.8x"),
                    ("Deceleration", "0.9x")
                ]
            case 1: // Behavior
                return [
                    ("Auto Eject", "Enabled"),
                    ("Auto Split", "Disabled"),
                    ("Collision Detection", "On")
                ]
            case 2: // Visual
                return [
                    ("Show Grid", "On"),
                    ("Show Names", "On"),
                    ("Particle Effects", "High")
                ]
            default:
                return []
            }
            
        case "Zoom":
            switch tabIndex {
            case 0: // Level
                return [
                    ("Zoom Level", "1.0x"),
                    ("Min Zoom", "0.5x"),
                    ("Max Zoom", "3.0x")
                ]
            case 1: // Smooth
                return [
                    ("Smooth Zoom", "Enabled"),
                    ("Zoom Speed", "0.5s"),
                    ("Follow Player", "On")
                ]
            case 2: // Auto
                return [
                    ("Auto Zoom", "Enabled"),
                    ("Zoom on Split", "On"),
                    ("Zoom Sensitivity", "Medium")
                ]
            default:
                return []
            }
            
        case "Macro":
            switch tabIndex {
            case 0: // Split
                return [
                    ("Split Delay", "50ms"),
                    ("Split Speed", "Fast"),
                    ("Multi Split", "Enabled")
                ]
            case 1: // Feed
                return [
                    ("Feed Delay", "30ms"),
                    ("Feed Amount", "10"),
                    ("Auto Feed", "Disabled")
                ]
            case 2: // Eject
                return [
                    ("Eject Delay", "40ms"),
                    ("Eject Power", "High"),
                    ("Eject Direction", "Auto")
                ]
            default:
                return []
            }
            
        case "Mastersplit":
            switch tabIndex {
            case 0: // Mode
                return [
                    ("Split Mode", "Sequential"),
                    ("Split Pattern", "Optimal"),
                    ("Merge Detection", "On")
                ]
            case 1: // Speed
                return [
                    ("Split Frequency", "2.0x"),
                    ("Reaction Time", "100ms"),
                    ("Burst Mode", "Enabled")
                ]
            case 2: // Advanced
                return [
                    ("AI Prediction", "On"),
                    ("Threat Detection", "High"),
                    ("Escape Mode", "Enabled")
                ]
            default:
                return []
            }
            
        case "Map":
            switch tabIndex {
            case 0: // Style
                return [
                    ("Map Theme", "Dark"),
                    ("Grid Style", "Dots"),
                    ("Border Color", "White")
                ]
            case 1: // Size
                return [
                    ("Map Scale", "1.0x"),
                    ("Cell Size", "Medium"),
                    ("Minimap Size", "Large")
                ]
            case 2: // Opacity
                return [
                    ("Map Opacity", "80%"),
                    ("Grid Opacity", "50%"),
                    ("Player Indicator", "100%")
                ]
            default:
                return []
            }
            
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("\(menuItem)")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .padding()
            
            VStack(spacing: 12) {
                ForEach(settings, id: \.0) { label, value in
                    SettingRow(label: label, value: value)
                }
            }
            .padding()
            .background(Color(red: 0.25, green: 0.25, blue: 0.25))
            .cornerRadius(8)
            .padding()
            
            Spacer()
        }
    }
}

struct SettingRow: View {
    let label: String
    let value: String
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.white)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
        .cornerRadius(6)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    ContentView()
}
