//
//  ModelPreview.swift
//  ShowStubs
//
//  Created by Michael on 6/15/23.
//

import SwiftData
import SwiftUI

extension ShowData {
    static let preview = try! ModelContainer(for: schema, configurations: [ModelConfiguration(inMemory: true)])
}

public extension View {
    func previewContainer() -> some View {
        self
            .modifier(PreviewDataGenerator())
            .modelContainer(ShowData.preview)
    }
}

struct PreviewDataGenerator: ViewModifier {
    @Environment(\.modelContext) private var modelContext
    
    func body(content: Content) -> some View {
        content.onAppear {
            PreviewData.generateData(for: modelContext)
        }
    }
}

public struct ModelPreview<Model: PersistentModel, Content: View>: View {
    var content: (Model) -> Content
    
    public init(@ViewBuilder content: @escaping (Model) -> Content) {
        self.content = content
    }
    
    public var body: some View {
        ZStack {
            PreviewContentView(content: content)
        }
        .previewContainer()
    }
    
    struct PreviewContentView: View {
        var content: (Model) -> Content
        
        @Query private var models: [Model]
        @State private var waitedToShowIssue = false
        
        var body: some View {
            if let model = models.first {
                content(model)
            } else {
                ContentUnavailableView {
                    Label {
                        Text(verbatim: "Could not load model for previews")
                    } icon: {
                        Image(systemName: "xmark")
                    }
                }
                .opacity(waitedToShowIssue ? 1 : 0)
                .task {
                    Task {
                        try await Task.sleep(for: .seconds(1))
                        waitedToShowIssue = true
                    }
                }
            }
        }
    }
}
