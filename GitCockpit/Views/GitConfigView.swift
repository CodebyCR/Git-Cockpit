
import Foundation
import SwiftUI





struct GitConfigView: View{


    init() {
        GitGlobalConfig.parseGlobalGitConfig { result in
            switch result {
            case .success(let gitConfig):
                print("GitConfig: \(gitConfig)")
            case .failure(let failure):
                print("Error: \(failure)")
            }
        }
    }

    var body: some View {
        Text("GitConfigView")
    }
    





}
