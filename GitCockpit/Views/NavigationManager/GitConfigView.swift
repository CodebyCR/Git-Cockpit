import SwiftUI

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
                Section(header: Text(LocalizedStringKey("User Information")).fontWeight(.bold)) {
                    LabeledContent(LocalizedStringKey("Name"), value: name)
                        .frame(width: 300)

                    LabeledContent(LocalizedStringKey("Email"), value: email)
                        .frame(width: 300)
                }

                Section(header: Text(LocalizedStringKey("Repository Information")).fontWeight(.bold)) {
                    LabeledContent(LocalizedStringKey("Default Branch"), value: defaultBranch)
                        .frame(width: 300)
                }
            }.navigationTitle(SidebarItem.gitConfig.displayName)
        }
    }
}
