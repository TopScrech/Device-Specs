import SwiftUI
import Charts

struct CpuUsageChart: View {
    private let cpuUsage: [Double]
    
    init(_ cpuUsage: [Double]) {
        self.cpuUsage = cpuUsage
    }
    
    var body: some View {
        Chart {
            ForEach(0..<cpuUsage.count, id: \.self) { index in
                BarMark(
                    x: .value("Core", index + 1),
                    y: .value("Usage", cpuUsage[index] * 100)
                )
                .foregroundStyle(color(cpuUsage[index]))
            }
            
            // LineMarks representing the max CPU load at 100
            LineMark(
                x: .value("Max", 0),
                y: .value("Max Load", 100)
            )
            .foregroundStyle(.clear)
            
            LineMark(
                x: .value("Max", cpuUsage.count),
                y: .value("Max Load", 100)
            )
            .foregroundStyle(.clear)
        }
        .chartXAxis {
            AxisMarks(position: .bottom)
        }
        .chartYAxis {
            AxisMarks(position: .leading)
        }
        .chartXScale(domain: 0...(cpuUsage.count + 1))
        .frame(height: 200)
        .padding()
    }
    
    private func color(_ usage: Double) -> Color {
        switch usage {
        case 0..<0.2: .green
        case 0.2..<0.5: .yellow
        case 0.5..<0.8: .orange
        case 0.8...1: .red
        default: .gray
        }
    }
}
