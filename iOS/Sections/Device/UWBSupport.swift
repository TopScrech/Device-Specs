enum UWBSupport {
    case notSupported, gen1, gen2

    var title: String {
        switch self {
        case .notSupported: "Not supported"
        case .gen1: "Generation 1"
        case .gen2: "Generation 2"
        }
    }
}
