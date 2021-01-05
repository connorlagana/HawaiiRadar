//
//  RollingView.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI

import SwiftUI

struct RollingCounterAnimation {
    @State var enteredNumber = 10
    @State var total = 0
    
    var body: some View {
        Text("\(total)")
            .font(.system(size: 18, weight: .medium, design: .serif))
            .foregroundColor(.green)
    }
    
    /// Creates a rolling animation while adding entered number
    func addNumberWithRollingAnimation() {
        withAnimation {
            // Decide on the number of animation steps
            let animationDuration = 1000 // milliseconds
            let steps = min(abs(self.enteredNumber), 100)
            let stepDuration = (animationDuration / steps)
            
            // add the remainder of our entered num from the steps
            total += self.enteredNumber % steps
            // For each step
            (0..<steps).forEach { step in
                // create the period of time when we want to update the number
                // I chose to run the animation over a second
                let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                let deadline = DispatchTime.now() + updateTimeInterval
                
                // tell dispatch queue to run task after the deadline
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    // Add piece of the entire entered number to our total
                    self.total += Int(self.enteredNumber / steps)
                }
            }
        }
    }
}

struct RollingNumberAnimation: View {
    @State var total = 0
    @State var enteredNumber = 10
    @State var showAnimation = false
    var backgroundColor = Color.white
    
    var body: some View {
        VStack {
            Text("Transaction Animator")
            Capsule()
                .foregroundColor(.clear)
            
            // Animation counting number
            ZStack(alignment: .center) {
                // current transaction "price"
                Text("$\(enteredNumber)")
                    .foregroundColor(enteredNunberIsPositive ? .green : .red)
                    .offset(x: 0, y: self.showAnimation ? -25 : -10)
                    .scaleEffect(self.showAnimation ? 1.25 : 0, anchor: .bottom)
                    .animation(Animation.spring(dampingFraction: 0.7).speed(0.8))
                
                Text("$\(total)")
                    // create a barrier from the total and scaled animation
                   .background(Rectangle().foregroundColor(self.backgroundColor))
            }
            .font(.system(size: 18, weight: .medium, design: .serif))
            
            
            Form {
                // transaction cost stepper
                Stepper(onIncrement: {
                    guard self.isAnimationAllowed else { return }
                    self.enteredNumber += 101
                }, onDecrement: {
                    guard self.isAnimationAllowed else { return }
                    self.enteredNumber -= 101
                }) {
                    Text("$\(enteredNumber)")
                }
                .padding(.horizontal)
                
                // button to add transaction
                Button(action: { self.addNumberWithRollingAnimation()}) {
                    Text("Submit Transaction")
                }
            }
        }
    }
}
extension RollingNumberAnimation {
    var enteredNunberIsPositive: Bool {
        enteredNumber > 0 // technically zero isn't positive lol
    }
    
    // guard against adding animation during another animation
    var isAnimationAllowed: Bool{
        !self.showAnimation
    }
    
    func addNumberWithRollingAnimation() {
        guard isAnimationAllowed else { return }
        
        withAnimation {
            // show scale animation
            self.showAnimation = true
            
            // Decide on the number of animation steps
            let animationDuration = 1000 // milliseconds
            let steps = min(abs(self.enteredNumber), 100)
            let stepDuration = (animationDuration / steps)
            
            // add the remainder of our entered num from the steps
            self.total += self.enteredNumber % steps
            
            (0..<steps).forEach { step in
                let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                let deadline = DispatchTime.now() + updateTimeInterval
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    // Add piece of the entire entered number to our total
                    self.total += Int(self.enteredNumber / steps)
                }
            }
            
            // hide scale animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.showAnimation = false
            }
        }
    }
}


struct RollingView_Previews: PreviewProvider {
    static var previews: some View {
        RollingNumberAnimation()
    }
}
