import Foundation
import SwiftUI

struct CustomSegmentComponent: View {
    @Binding var selectedSegment: String
    var caseArray: Array<String>
    var body: some View {
        HStack(spacing: 0) {
            ForEach(self.caseArray, id: \.self) { caseName in
                Text(caseName)
                    .fontWeight(.medium)
                    .foregroundStyle(self.selectedSegment == caseName ? .black : .white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    .hoverBackground(
                        normal: self.selectedSegment == caseName ? .white : .white.opacity(0.08),
                        hover: .white.opacity(0.15),
                        animation: nil
                    )
                    .background(self.selectedSegment == caseName ? .white : .white.opacity(0.08))
                    .pointerMouseHoverEffect()
                    .onTapGesture {
                        if self.selectedSegment == caseName { return }
                        self.selectedSegment = caseName
                    }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .stroke(.white.opacity(0.1), lineWidth: 1)
        }
    }
}
