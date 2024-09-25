import ComposableArchitecture
import SwiftUI

public struct TopView: View {
    var store: StoreOf<Top>

    public init(store: StoreOf<Top>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            VStack {
                Text(store.title)
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .center)

                Button {
                    store.send(.onTapButton)
                } label: {
                    Text("Tap")
                        .foregroundStyle(Color.white)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.cyan)
                        }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()
            }
            .padding()
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}
