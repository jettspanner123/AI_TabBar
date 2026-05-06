import Foundation
import SwiftUI

struct HoverAnimationExtension: ViewModifier {
    var backgroundColor: Color
    var hoverColor: Color
    var animation: Animation? = .easeInOut(duration: 0.3)
    var cursor: NSCursor = .pointingHand
    
    @State private var isHovered: Bool = false
    
    func body(content: Content) -> some View {
        content
            .background(self.isHovered ? self.hoverColor : self.backgroundColor)
            .onHover { isHovered in
                if isHovered {
                    self.cursor.set()
                } else {
                    NSCursor.arrow.set()
                }
                
                if self.animation == nil {
                    self.isHovered = isHovered
                    return
                }
                
                withAnimation {
                    self.isHovered = isHovered
                }
            }
    }
}

extension View {
    func pointerMouseHoverEffect() -> some View {
        self.onHover { hoverState in
            if hoverState {
                NSCursor.pointingHand.set()
                return
            }
            NSCursor.arrow.set()
        }
    }
    func hoverBackground(
        normal: Color,
        hover: Color,
        animation: Animation? = .easeInOut(duration: 0.3),
        cursor: NSCursor = .pointingHand
    ) -> some View {
        self.modifier(
            HoverAnimationExtension(
                backgroundColor: normal,
                hoverColor: hover,
                animation: animation,
                cursor: cursor
            )
        )
    }
}
