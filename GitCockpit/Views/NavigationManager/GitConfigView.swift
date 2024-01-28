import Foundation
import SwiftUI

// struct GitConfigView: View {
//     private let gitConfig: GlobalGitConfig
//     private var content: [String: [String: String]]?

//     init() {
//         self.gitConfig = GlobalGitConfig()
//         self.content = gitConfig.getContent()
//     }

//     var body: some View {
//         VStack(alignment: .leading) {
//             Text("Defaulf Branch Name: \(content?["init"]?["defaultBranch"] ?? "-")")

//             Text("Name: \(content?["user"]?["name"] ?? "-")")

//             Text("Email: \(content?["user"]?["email"] ?? "-")")
//         }
//     }
// }
// import SwiftUI

struct GitConfigView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var defaultBranch: String = ""

    private let gitConfig: GlobalGitConfig

    init() {
        self.gitConfig = GlobalGitConfig()
        let content = gitConfig.getContent()
        _name = State(initialValue: content?["user"]?["name"] ?? "")
        _email = State(initialValue: content?["user"]?["email"] ?? "")
        _defaultBranch = State(initialValue: content?["init"]?["defaultBranch"] ?? "")
    }

    var body: some View {
        NavigationStack {
            Form {
                Section(header:
                    Text("User Information")
                        //                    .font(font: Font?.self, size: CGFloat(14))
                        .fontWeight(.bold))
                {
                    LabeledContent("Name", value: name)
                        .frame(width: 300)

                    LabeledContent("Email", value: email)
                        .frame(width: 300)
                }

                //            HStack(alignment: .leading, content: {
                //                /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
                //            }) {
                //                Text("Repository Information")
                //                    //                    .font(font: Font?.self, size: CGFloat(14))
                //                    .fontWeight(.bold)
                //            }
                Section(header:
                    Text("Repository Information")
                        //                    .font(font: Font?.self, size: CGFloat(14))
                        .fontWeight(.bold))
                {
                    LabeledContent("Default Branch", value: defaultBranch)
                        .frame(width: 300)
                }
            }.navigationTitle(SidebarItem.gitConfig.displayName)
        }
    }
}

// import SwiftUI
//
// struct SettingsView: View {
//    var body: some View {
//        ScrollView {
//            VStack {
//                // Titelleiste
//                Text("Einstellungen")
//                    .font(.title)
//                    .padding(.top, 20)
//
//                // Suche
////                SearchBar()
//
//                // Benutzerprofil
//                NavigationLink(destination: ProfileView()) {
//                    HStack {
//                        Image(systemName: "person.circle")
//                            .resizable()
//                            .frame(width: 40, height: 40)
//
//                        Text("Christoph Rohde")
//                            .font(.headline)
//                    }
//                }
//
//                // Abschnitte
//                Section(header: Text("Allgemein")) {
//                    // WLAN
//                    Toggle(isOn: $isWifiEnabled) {
//                        Text("WLAN")
//                    }
//
//                    // Bluetooth
//                    Toggle(isOn: $isBluetoothEnabled) {
//                        Text("Bluetooth")
//                    }
//
//                    // Netzwerk
//                    NavigationLink(destination: NetworkView()) {
//                        Text("Netzwerk")
//                    }
//                }
//
//                Section(header: Text("Benachrichtigungen")) {
//                    // Mitteilungen
//                    NavigationLink(destination: NotificationsView()) {
//                        Text("Mitteilungen")
//                    }
//
//                    // Ton
//                    NavigationLink(destination: TonesView()) {
//                        Text("Ton")
//                    }
//
//                    // Fokus
//                    NavigationLink(destination: FocusView()) {
//                        Text("Fokus")
//                    }
//                }
//
//                Section(header: Text("Leistung")) {
//                    // Bildschirmzeit
//                    NavigationLink(destination: ScreenTimeView()) {
//                        Text("Bildschirmzeit")
//                    }
//
//                    // Speicher
//                    NavigationLink(destination: StorageView()) {
//                        Text("Speicher")
//                    }
//                }
//            }
//        }
//    }
// }
