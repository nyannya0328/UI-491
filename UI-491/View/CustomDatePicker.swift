//
//  CustomDatePicker.swift
//  UI-491
//
//  Created by nyannyan0328 on 2022/03/04.
//

import SwiftUI

struct CustomDatePicker: View {
    
    @State var animatedValue : [Bool] = Array(repeating: false, count: 3)
    
    
    @Binding var currentDate : Date
    @State var currentMonth : Int = 0
    
    
    var body: some View {
        VStack{
            
            
            HStack(spacing:20){
                
                Button {
                    
                    withAnimation{
                        
                        currentMonth -= 1
                    }
                    
                } label: {
                    
                    Image(systemName: "chevron.left")
                        .font(.title3)
                }
                
                
                
                Text(extractDate()[0] + " " + extractDate()[1])
                    .font(.title.weight(.semibold))
                
                
                Button {
                    
                    withAnimation{
                        
                        currentMonth += 1
                    }
                    
                } label: {
                    
                    Image(systemName: "chevron.right")
                        .font(.title3)
                }


                
            }
            .foregroundColor(.white)
            
            
            
            Rectangle()
                .fill(.white)
                .frame(width: animatedValue[0] ? nil : 1, height: 1)
                .padding(.vertical,6)
                .frame(maxWidth:.infinity,alignment: .leading)
            
            
            
            if animatedValue[0]{
                
                
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 7)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    
                    
                    ForEach(0..<extracteDateValue().count,id:\.self){index in
                        
                        let value = extracteDateValue()[index]
                        
                        
                        
                        PickerCardView(value: value, index: index, currentDate: $currentDate, isFinished: $animatedValue[1])
                            .onTapGesture {
                                
                                
                                currentDate = value.date
                            }
                        
                            
                        
                        
                    }
                    
                }
                
                
            }
            
            else{
                
                let columns = Array(repeating: GridItem(.flexible(),spacing: 10), count: 7)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    
                    
                    
                    ForEach(0..<extracteDateValue().count,id:\.self){index in
                        
                        let value = extracteDateValue()[index]
                        
                        
                        
                        PickerCardView(value: value, index: index, currentDate: $currentDate, isFinished: $animatedValue[1])
                            .onTapGesture {
                                
                                
                                currentDate = value.date
                            }
                        
                            
                        
                        
                    }
                    
                }
                .opacity(0)
                
                
                
                
                
                
                
                
                
            }
            
        }
        .padding()
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                
                
                withAnimation(.easeInOut(duration: 0.3)){
                    
                    animatedValue[0] = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3){
                    
                    
                    
                    animatedValue[1] = true
                }
                
                
                
            }
        }
    }
    
    func getCurrentMonth()->Date{
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())else{
            
            
            return Date()
        }
        
        return currentMonth
    }
    
    func extractDate()->[String]{
        let calendar = Calendar.current
        
        let month = calendar.component(.month, from: currentDate) - 1
        
        let year = calendar.component(.year, from: currentDate)
        
        return ["\(year)",calendar.monthSymbols[month]]
        
        
        
        
    }
    
    func extracteDateValue() -> [DateValue]{
        
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            
            
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let fisetWeek = calendar.component(.weekday, from: days.first!.date)
        
        for _ in 0..<fisetWeek - 1{
            
            
            days.insert(DateValue(day: -1, date: Date()), at: 0)
            
            
            
        }
        
        return days
        
        
    }
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func isSampleday(date1 : Date,date2:Date) -> Bool{
    
    let calendar = Calendar.current
    
    return calendar.isDate(date1, inSameDayAs: date2)
    
}


struct PickerCardView : View{
    
    
    var value : DateValue
    var index : Int
    
    @Binding var currentDate : Date
    
    @State var showView : Bool = false
    
    @Binding var isFinished : Bool
    
    
    var body: some View{
        
        VStack{
            
            
            if value.day != -1{
                
                
                Text("\(value.day)")
                    .font(.callout.weight(.bold))
                    .foregroundColor(isSampleday(date1: value.date, date2: currentDate) ? .black : .white)
                    .frame(maxWidth:.infinity)
            }
            
        }
        .background(
        
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(.white)
                .padding(.vertical,-5)
                .padding(.horizontal,-5)
                .opacity(isSampleday(date1: value.date, date2: currentDate) ? 1 : 0)
        
        
        )
        .opacity(showView ? 1 : 0)
        .onAppear {
            
            if isFinished{showView = true}
            
            withAnimation(.spring().delay(Double(index) * 0.03)){
                
                
                showView = true
            }
        }
    }
    
    
}

extension Date{
    
    
    
    func getAllDates()->[Date]{
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: calendar.dateComponents([.year,.month], from: self))!
        
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        
        return range.compactMap({ day -> Date in
            
            
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        })
        
        
        
        
        
    }
    
}
