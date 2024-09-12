import ScrechKit
import DeviceKit

struct ProcessorView: View {
    private var vm = ProcessorVM()
    
    var body: some View {
        List {
            ListParameter("Core count", parameter: vm.cores.description)
            
            ListParameter("Active core count", parameter: vm.activeCores.description)
            
            let cpu = Device.current.cpu.description
            ListParameter("CPU", parameter: cpu)
            
            ListParameter("Architecture", parameter: vm.arch)
        }
    }
}

#Preview {
    ProcessorView()
}
