//
//  RepoGridView.swift
//  GraphenAutomator
//
//  Created by Christoph Rohde on 19.10.23.
//

import Foundation
import SwiftUI

struct RepoGridView: View {
    var repos: [RepositoryModel] = RepositoryModel.getDemoRepos()
    let gradientColors: [Color] = [.purple, .indigo, .blue, .cyan]

    private let adaptiveColumns = [
        // should be the same like frame width
        GridItem(.adaptive(minimum: 440))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: adaptiveColumns,
                      spacing: 20)
            {
                ForEach(repos, id: \.self) { repo in
                    ZStack {
                        getGradient()
                            .frame(width: 440, height: 200)
                            .cornerRadius(30)
                        Text("\(repo.name)")
                            .foregroundColor(.white)
                            .font(.system(size: 30,
                                          weight: .medium,
                                          design: .rounded))
                        VStack {
                            Spacer()
                            HStack {
                                Button("Show",
                                       systemImage: "folder",
                                       action: { repo.showLocal() })
                                    .buttonStyle(.borderless)
                                    .foregroundColor(Color.white)
                                    .padding()

                                if repo.remote != nil {
                                    Button("Remote",
                                           systemImage: "network",
                                           action: { repo.showRemote() })
                                        .buttonStyle(.borderless)
                                        .foregroundColor(Color.white)
                                        .padding()
                                }
                                
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }

    func getGradient() -> LinearGradient {
        return LinearGradient(
            gradient: Gradient(colors: gradientColors),
            startPoint: .bottomLeading,
            endPoint: .topTrailing
        )
    }
}

#Preview("RepoGridView") {
    RepoGridView()
        .frame(width: 600)
}
