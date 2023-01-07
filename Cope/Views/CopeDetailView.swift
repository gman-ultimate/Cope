//
//  CopeDetailView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

struct CopeDetailView: View {
    @StateObject var item: Item

    var body: some View {
        ScrollView(.vertical) {
            VStack(alignment: .leading, spacing: 15) {
                ZStack(alignment: .bottomLeading) {
                    Image(systemName: item.symbol ?? "exclamationmark.triangle")
                        .font(.system(size: 60))
                        .foregroundColor(.accentColor)
                        .frame(maxWidth: .infinity)
                        .frame(minHeight: 230)
                        .background(Color.accentColor.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    
                    Text("Used \(item.usedCount) times")
                        .foregroundColor(.accentColor)
                        .font(.callout)
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                        .padding(.bottom, 15)
                }
                
                VStack {
                    HStack(spacing: 15) {
                        if item.usedCount > 0 {
                            Text("Remove a Count")
                                .foregroundColor(.white)
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity)
                                .background(Color.accentColor.opacity(0.5))
                                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                        }
                        
                        Text("Add a Count")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .background(Color.accentColor.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                    }
                }
                
                Divider().opacity(0)
                
                CopeDetailCardView(value: item.isDistraction, positive: "Can be used as a distraction.", negitive: "Not designed to be a distraction", type: "Distraction")
                
                CopeDetailCardView(value: item.dizzyHelpful, positive: "Can be used to help while dizzy.", negitive: "Not designed to be done when dizzy.", type: "While Dizzy")
                
                CopeDetailCardView(value: item.painHelpful, positive: "Can be used to help while in extreme pain.", negitive: "Not designed to be used while in extreme pain.", type: "During Extreme Pain")
                
                CopeDetailCardView(value: item.whileExercising, positive: "Can be used as a break or strategy while exercising.", negitive: "Not designed to be used as a break or strategy while exercising.", type: "While Exercising")
                
                Divider().opacity(0)
                
                if item.details != "" {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Details")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    Text(item.details ?? "ERROR: Details cannot be fetched!")
                }
                .padding(26)
                .frame(maxWidth: .infinity)
                .background(Color.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                }
            }
            .padding()
        }
        .navigationTitle(item.name ?? "Unknown")
    }
}

struct CopeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CopeListView()
    }
}
