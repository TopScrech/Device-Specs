import ScrechKit

struct GoidaCameraView: View {
    private var vm = CameraVM()
    
    var body: some View {
        List {
#if DEBUG
            Button("Front camera test") {
                vm.fetchCameraData(.front)
            }
            
            Button("Back camera test") {
                vm.fetchCameraData(.back)
            }
#endif
            Section("Front Camera") {
                ListParameter("Max Photo Resolution", 
                              parameter: vm.frontMaxPhotoResolution)
                
                ListParameter("Apperture",
                              parameter: vm.frontApperture)
                
                ListParameter("Optical Stabilization",
                              parameter: vm.frontOpticalStabilization)
            }
        }
        .navigationTitle("Camera")
    }
}

#Preview {
    GoidaCameraView()
}
