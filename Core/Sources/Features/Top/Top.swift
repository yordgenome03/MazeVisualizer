import Foundation
import ComposableArchitecture

@Reducer
public struct Top {
    
    @ObservableState
    public struct State {
        var title = "Initial Title"
        var titleList: [String] = []
        
        public init() {}
    }
    
    public enum Action: BindableAction {
        case onAppear
        case onTapButton
        case binding(BindingAction<State>)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.title = "Appear"
                return .none
            case .onTapButton:
                state.title = "Tapped"
                return .none
            case .binding:
                return .none
            }
        }        
    }
}
