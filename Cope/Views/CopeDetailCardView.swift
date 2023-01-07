//
//  CopeDetailCardView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

struct CopeDetailCardView: View {
    var value: Bool
    var positive: String
    var negitive: String
    var type: String
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(type)?")
                        .font(.title3)
                        .fontWeight(.semibold)
                    Spacer()
                }
                Text(value ? positive : negitive)
                    .font(.callout)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Image(systemName: value ? "hand.thumbsup" : "hand.thumbsdown")
                .font(.system(size: 25))
                .foregroundColor(.white)
                .padding(12)
                .background(Color.accentColor.opacity(value ? 1.0 : 0.4))
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .padding(.leading, 14)
        }
        .padding(26)
        .frame(maxWidth: .infinity)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct CopeDetailCardView_Previews: PreviewProvider {
    static var previews: some View {
        CopeDetailCardView(value: true, positive: "Can be used as a distraction.", negitive: "Not designed to be a distraction", type: "Distraction")
            .previewLayout(.sizeThatFits)
    }
}
