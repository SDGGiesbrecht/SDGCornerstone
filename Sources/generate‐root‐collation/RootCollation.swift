/*
 RootCollation.swift

 This source file is part of the SDGCornerstone open source project.
 https://sdggiesbrecht.github.io/SDGCornerstone

 Copyright ©2019–2020 Jeremy David Giesbrecht and the SDGCornerstone project contributors.

 Soli Deo gloria.

 Licensed under the Apache Licence, Version 2.0.
 See http://www.apache.org/licenses/LICENSE-2.0 for licence information.
 */

import SDGCollation

extension CollationOrder {

  if !os(WASI)  // #workaround(Swift 5.3.1, FileManager unavailable.)
    static func generateRoot() throws -> CollationOrder {
      print("Tailoring root collation...")
      let root = try ducet().tailored {

        "<_end_>" ←< "<and>" ←< "<alt>" ←< "<sub>"

        "̀" ←= "<̀‐it>"  // Original
        "́" ←= "<́‐el>"  // Original
        "̂" ←= "<̂‐pt>"  // Reset later
        "̌" ←= "<̌‐cs>"  // Original
        "̈" ←= "<̈‐el>"  // Original

        "<_ReverseAccent_>" ←<< "<́‐fr>" ←<< "<̀‐fr>" ←<< "<̂‐fr>" ←<< "<̈‐fr>"
          ←<< "̧" /* Original (fr) */
        "<̂‐fr>" ←= "̂"  // Original

        "<digraph>" <→ "<̌‐hr>" <→ "<́‐pl>" <→ "<̈‐hu>" <→ "̃" /* Original (es) */ <→ "<stroke>"
          <→ "<_final_>"

        /* a */"א" <<<<<<→ /*‎*/ "ܐ" <<<<<<→ "α" <<<<<<→ "a"
        "Α" <<<<<<→ "A"

        /* b */"ב" <<<<<<→ /*‎*/ "ܒ" <<<<<<→ "β" <<<<<<→ "b"
        "Β" <<<<<<→ "B"
        /*‎*/"ܒ" ←<<< /*‎*/ "ܭ"

        /* c */"ג" <<<<<<→ /*‎*/ "ܓ" <<<<<<→ "γ" <<<<<<→ "c"
        "Γ" <<<<<<→ "C"
        "ᴦ" <<<<<<→ "ᴄ"
        /*‎*/"ܓ" ←<<< /*‎*/ "ܔ" ←<<< /*‎*/ "ܮ"

        /* d */"ד" <<<<<<→ /*‎*/ "ܕ" <<<<<<→ /*‎*/ "ܖ" <<<<<<→ "δ" <<<<<<→ "d"
        "Δ" <<<<<<→ "D"
        /*‎*/"ܕ" ←<<< /*‎*/ "ܯ"

        "D<stroke>" ←= "Đ"
        "d<stroke>" ←= "đ"

        /* e */"ה" <<<<<<→ /*‎*/ "ܗ" <<<<<<→ "ε" <<<<<<→ "e"
        "e" ←<<<<<< "<̈‐de‐tel>"
        "Ε" <<<<<<→ "E"

        /* f */"ו" <<<<<<→ /*‎*/ "ܘ" <<<<<<→ "ϝ" <<<<<<→ "ͷ" <<<<<<→ "ϛ" <<<<<<→ "f"
        "Ϝ" <<<<<<→ "Ͷ" <<<<<<→ "Ϛ" <<<<<<→ "F"

        /* g */"ז" <<<<<<→ /*‎*/ "ܙ" <<<<<<→ "ζ" <<<<<<→ "g"
        "Ζ" <<<<<<→ "G"
        "g" ←< "ݍ"

        /* h */"ח" <<<<<<→ /*‎*/ "ܚ" <<<<<<→ "η" <<<<<<→ "h"
        "Η" <<<<<<→ "H"

        "ͱ" <<<<<<→ "ⱶ"
        "Ͱ" <<<<<<→ "Ⱶ"

        /* θ */"ט" <<<<<<→ /*‎*/ "ܛ" <<<<<<→ "θ" <→ "i"
        "θ" ←<<<< "Θ"
        /*‎*/"ܛ" ←<<< /*‎*/ "ܜ"

        /* i */"י" <<<<<<→ /*‎*/ "ܝ" <<<<<<→ "ι" <<<<<<→ "i"
        "Ι" <<<<<<→ "I"

        "j" ←<<<<<< "ϳ"
        "J" ←<<<<<< "Ϳ"

        "j" ←< /*‎*/ "ܞ"

        /* k */"כ" <<<<<<→ /*‎*/ "ך" <<<<<<→ /*‎*/ "ܟ" <<<<<<→ "κ" <<<<<<→ "k"
        "Κ" <<<<<<→ "K"
        "k" ←< "ݎ"

        /* l */"ל" <<<<<<→ /*‎*/ "ܠ" <<<<<<→ "λ" <<<<<<→ "l"
        "Λ" <<<<<<→ "L"
        "ᴧ" <<<<<<→ "ʟ"

        /* m */"מ" <<<<<<→ /*‎*/ "ם" <<<<<<→ /*‎*/ "ܡ" <<<<<<→ "μ" <<<<<<→ "m"
        "Μ" <<<<<<→ "M"

        /* n */"נ" <<<<<<→ /*‎*/ "ן" <<<<<<→ /*‎*/ "ܢ" <<<<<<→ "ν" <<<<<<→ "n"
        "Ν" <<<<<<→ "N"

        /* ξ */"ס" <<<<<<→ /*‎*/ "ܣ" <<<<<<→ "ξ" <→ "o"
        "ξ" ←<<<< "Ξ"
        /*‎*/"ܣ" ←<<<< /*‎*/ "ܤ"

        /* o */"ע" <<<<<<→ /*‎*/ "ܥ" <<<<<<→ "ο" <<<<<<→ "o"
        "Ο" <<<<<<→ "O"

        /* p */"פ" <<<<<<→ /*‎*/ "ף" <<<<<<→ /*‎*/ "ܦ" <<<<<<→ "π" <<<<<<→ "p"
        "Π" <<<<<<→ "P"
        "ᴨ" <<<<<<→ "ᴘ"
        /*‎*/"ܦ" ←<<< /*‎*/ "ܧ"
        "p" ←< "ݏ"

        /* ϻ */"צ" <<<<<<→ /*‎*/ "ץ" <<<<<<→ /*‎*/ "ܨ" <<<<<<→ "ϻ" <→ "q"
        "ϻ" ←<<<< "Ϻ"

        /* q */"ק" <<<<<<→ /*‎*/ "ܩ" <<<<<<→ "ϙ" <<<<<<→ "ϟ" <<<<<<→ "q"
        "Ϙ" <<<<<<→ "Ϟ" <<<<<<→ "Q"

        /* r */"ר" <<<<<<→ /*‎*/ "ܪ" <<<<<<→ "ρ" <<<<<<→ "ϼ" <<<<<<→ "r"
        "Ρ" <<<<<<→ "R"
        "ᴩ" <<<<<<→ "ʀ"

        /* s */"ש" <<<<<<→ /*‎*/ "ܫ" <<<<<<→ "σ" <<<<<<→ "ς" <<<<<<→ "s"
        "Σ" <<<<<<→ "S"
        "σ" ←<<<<< "ͼ"
        "Σ" ←<<<<< "Ͼ"
        "ͼ" ←<<<<< "ͻ"
        "Ͼ" ←<<<<< "Ͻ"
        "ͻ" ←<<<<< "ͽ"
        "Ͻ" ←<<<<< "Ͽ"

        /* t */"ת" <<<<<<→ /*‎*/ "ܬ" <<<<<<→ "τ" <<<<<<→ "t"
        "Τ" <<<<<<→ "T"

        "υ" <<<<<<→ "v"
        "Υ" <<<<<<→ "V"

        "φ" <→ "x"
        "φ" ←<<<< "Φ"

        "χ" <<<<<<→ "x"
        "Χ" <<<<<<→ "X"

        "ψ" <→ "ω" <→ "ꭥ" <→ "ͳ" <→ "ϸ" <→ "y"
        "ψ" ←<<<< "Ψ"
        "ψ" ←< "ᴪ"

        "ω" ←<<<< "Ω"

        "ͳ" ←<<<< "Ͳ"
        "ͳ" ←<<<<<< "ϡ"
        "Ͳ" ←<<<<<< "Ϡ"

        "ϸ" ←<<<< "Ϸ"

        /* ff */"װ" ←<<<<<< /*‎*/ "וו"
        /* fi */"ױ" ←<<<<<< /*‎*/ "וי"
        /* ii */"ײ" ←<<<<<< /*‎*/ "יי"

        "και" ←<<<<<< "ϗ"
        "Και" ←<<<<<< "Ϗ"
      }
      print("Finished tailoring root collation.")
      return root
    }
  #endif
}
