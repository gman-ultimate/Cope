//
//  ChooserButtonView.swift
//  Cope
//
//  Created by Gary Doering on 1/6/23.
//

import SwiftUI

struct ChooserButtonView: View {
    var body: some View {
        Image(systemName: "arrow.triangle.swap")
            .imageScale(.large)
            .font(.title2.weight(.semibold))
            .foregroundColor(.white)
            .frame(minWidth: 50, minHeight: 50)
            .background(Color.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 2, y: 2)
            .padding(12)
            .background(Color.accentColor.opacity(0.7))
            .clipShape(RoundedRectangle(cornerRadius: 33, style: .continuous))
            .shadow(color: Color.black.opacity(0.2), radius: 3, x: 2, y: 2)
            .padding(12)
            .background(Color.accentColor.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 46, style: .continuous))
            .shadow(color: Color.black.opacity(0.1), radius: 6, x: 2, y: 2)
            .padding(.top)
    }
}

struct ChooserButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ChooserButtonView()
    }
}
