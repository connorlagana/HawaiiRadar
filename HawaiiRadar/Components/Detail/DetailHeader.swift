//
//  DetailHeader.swift
//  HawaiiRadar
//
//  Created by Connor Lagana on 1/3/21.
//

import SwiftUI



struct DetailHeader: View {
    var size: CGFloat = 30
    
//    @State var date = Date()
//    @State var format = DateFormatter()
//    @State var formattedDate: String?
    let date = Date()
    let calendar = Calendar.current
    
    @Binding var fButtonPressed: Bool
    @Binding var showingDetail: Bool
    
    var body: some View {
        HStack {
            Button {
                //dismiss
                print("dismissing")
                showingDetail.toggle()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white)
                    .shadow(radius: 5)
            }

            Spacer()
            HStack(spacing: 5) {
                Text("\(getWeekday(weekday: calendar.component(.weekday, from: date))),")
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Bold", size: 18))
                    
                Text((getMonth(month: calendar.component(.month, from: date))))
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Bold", size: 18))
                Text("\(calendar.component(.day, from: date))")
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Bold", size: 18))
                
            }
            .padding(.leading, size)
            Spacer()
            Button(action: {
                fButtonPressed.toggle()
            }, label: {
                Text("°F")
                    .foregroundColor(.white)
                    .font(Font.custom("Nunito-Bold", size: 18))
                    .frame(width: size, height: size, alignment: .leading)
            })
        }
        .padding(20)
        .onAppear {
//            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            formattedDate = format.string(from: date)
        }
    }
    
    func getWeekday(weekday: Int) -> String {
        switch weekday {
        case 1:
            return "Sun"
        case 2:
            return "Mon"
        case 3:
            return "Tue"
        case 4:
            return "Wed"
        case 5:
            return "Thu"
        case 6:
            return "Fri"
        case 7:
            return "Sat"
        default:
            return "\(weekday)"
        }
        return ""
    }
    
    func getMonth(month: Int) -> String {
        switch month {
        case 1:
            return "January"
        case 2:
            return "February"
        case 3:
            return "March"
        case 4:
            return "April"
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "August"
        case 9:
            return "September"
        case 10:
            return "October"
        case 11:
            return "November"
        case 12:
            return "December"
        default:
            return "\(month)"
        }
        return ""
    }
}


