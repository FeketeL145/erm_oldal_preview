// ═══════════════════════════════════════════════════════════════════════════════
// ELECTRIC RACING MISKOLC — WEB PLATFORM DEVELOPER & ARCHITECTURE MANUAL
// ═══════════════════════════════════════════════════════════════════════════════

#set document(
  title: "Electric Racing Miskolc — Web Platform Documentation",
  author: "Electric Racing Miskolc Engineering Team",
  date: auto
)

#set text(
  font: ("Inter", "Segoe UI", "Arial"),
  size: 10pt,
  fill: rgb("#1f2937"),
  lang: "hu"
)

#set par(
  justify: true,
  leading: 0.72em,
)

// Brand Colors
#let erm-blue = rgb("#29aae1")
#let erm-blue-light = rgb("#60c5f1")
#let erm-dark = rgb("#0b0c10")
#let erm-gray = rgb("#1f2833")
#let erm-gray-light = rgb("#f3f4f6")
#let erm-border = rgb("#e5e7eb")
#let erm-accent = rgb("#38bdf8")

// Page Setup
#set page(
  paper: "a4",
  margin: (top: 2.8cm, bottom: 2.5cm, left: 2.2cm, right: 2.2cm),
  header: context {
    let p = counter(page).get().first()
    if p > 1 [
      #grid(
        columns: (1fr, auto),
        align(left)[
          #text(size: 8.5pt, fill: rgb("#6b7280"), weight: "bold")[
            ELECTRIC RACING MISKOLC #text(fill: erm-blue)[\/\/] FEJLESZTŐI DOKUMENTÁCIÓ
          ]
        ],
        align(right)[
          #text(size: 8.5pt, fill: rgb("#9ca3af"))[Miskolci Egyetem • Formula Student]
        ]
      )
      #v(-3pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))
    ]
  },
  footer: context {
    let p = counter(page).get().first()
    if p > 1 [
      #line(length: 100%, stroke: 0.5pt + rgb("#e5e7eb"))
      #v(4pt)
      #grid(
        columns: (1fr, auto),
        align(left)[
          #text(size: 8pt, fill: rgb("#9ca3af"))[
            ERM Web Architecture & Maintenance Guide v1.0 • 2026
          ]
        ],
        align(right)[
          #text(size: 8.5pt, fill: erm-blue, weight: "bold")[
            #counter(page).display("1 / 1", both: true)
          ]
        ]
      )
    ]
  }
)

// Callout Box Component
#let callout(title: "INFORMÁCIÓ", body, color: erm-blue) = {
  rect(
    width: 100%,
    fill: color.lighten(94%),
    stroke: (left: 3.5pt + color, rest: 0.5pt + color.lighten(70%)),
    radius: (right: 3pt),
    inset: 10pt,
    [
      #text(weight: "bold", size: 8.5pt, fill: color, tracking: 0.1em)[#title]
      #v(3pt)
      #text(size: 9.5pt, fill: rgb("#374151"))[#body]
    ]
  )
}

// Tech Spec Pill
#let badge(txt, color: erm-blue) = {
  box(
    fill: color.lighten(90%),
    stroke: 0.5pt + color.lighten(50%),
    radius: 3pt,
    inset: (x: 5pt, y: 2pt),
    baseline: 0%,
    text(size: 7.5pt, weight: "bold", fill: color.darken(20%))[#txt]
  )
}

// ═══════════════════════════════════════════════════════════════════════════════
// COVER PAGE
// ═══════════════════════════════════════════════════════════════════════════════

#align(center + top)[
  #v(2.5cm)

  #rect(
    fill: erm-dark,
    radius: 6pt,
    inset: (x: 24pt, y: 14pt),
    stroke: 1.5pt + erm-blue
  )[
    #text(size: 11pt, weight: "bold", fill: erm-blue, tracking: 0.25em)[
      MISKOLCI EGYETEM • FORMULA STUDENT TEAM
    ]
  ]

  #v(1.2cm)

  #text(size: 28pt, weight: "bold", fill: erm-dark)[
    ELECTRIC RACING MISKOLC
  ]

  #v(-4pt)
  #text(size: 20pt, weight: "bold", fill: erm-blue)[
    Web Platform Architektúra & Rendszerdokumentáció
  ]

  #v(0.6cm)
  #text(size: 11pt, fill: rgb("#4b5563"))[
    Átfogó műszaki kézikönyv a weboldal felépítéséről, a komponensek működéséről, a 3D WebGL megjelenítőről, a kétnyelvű adatbázisról és a karbantartási feladatokról.
  ]

  #v(1.8cm)

  #grid(
    columns: (1fr, 1fr, 1fr),
    gutter: 12pt,
    rect(fill: erm-gray-light, inset: 10pt, radius: 4pt, stroke: 0.5pt + erm-border)[
      #text(size: 8pt, weight: "bold", fill: rgb("#6b7280"))[KERETRENDSZER]\
      #v(2pt)
      #text(weight: "bold", size: 10pt, fill: erm-dark)[Vite 8.3 (Vanilla JS)]
    ],
    rect(fill: erm-gray-light, inset: 10pt, radius: 4pt, stroke: 0.5pt + erm-border)[
      #text(size: 8pt, weight: "bold", fill: rgb("#6b7280"))[STÍLUSRENDSZER]\
      #v(2pt)
      #text(weight: "bold", size: 10pt, fill: erm-dark)[Tailwind CSS v4]
    ],
    rect(fill: erm-gray-light, inset: 10pt, radius: 4pt, stroke: 0.5pt + erm-border)[
      #text(size: 8pt, weight: "bold", fill: rgb("#6b7280"))[3D WEBGL MOTOR]\
      #v(2pt)
      #text(weight: "bold", size: 10pt, fill: erm-dark)[Three.js + Draco WASM]
    ]
  )

  #v(2.5cm)

  #line(length: 60%, stroke: 0.5pt + rgb("#d1d5db"))
  #v(0.3cm)

  #grid(
    columns: (1fr, 1fr),
    align(left)[
      #text(size: 8.5pt, fill: rgb("#6b7280"))[
        *Készítette:* ERM Frontend & Software Unit\
        *Projekt:* Electric Racing Miskolc Official Website\
        *Verzió:* 1.0 (Production Ready)
      ]
    ],
    align(right)[
      #text(size: 8.5pt, fill: rgb("#6b7280"))[
        *Kiadás dátuma:* 2026. október\
        *Célközönség:* Fejlesztők, Csapattagok, Menedzsment\
        *Tárhely:* `https://ermiskolc.hu`
      ]
    ]
  )
]

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// TARTALOMJEGYZÉK
// ═══════════════════════════════════════════════════════════════════════════════

#v(0.5cm)
#text(size: 16pt, weight: "bold", fill: erm-dark)[Tartalomjegyzék]
#v(0.3cm)

#outline(
  title: none,
  depth: 3,
  indent: auto
)

#v(1cm)
#line(length: 100%, stroke: 0.5pt + erm-border)

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// 1. BEVEZETÉS ÉS PROJEKT CÉLKITŰZÉSEK
// ═══════════════════════════════════════════════════════════════════════════════

= 1. Bevezetés és Projekt Célkitűzések

Az *Electric Racing Miskolc (ERM)* a Miskolci Egyetem hivatalos Formula Student csapata. A projekt célja egy olyan ultramodern, prémium megjelenésű és villámgyors landing page létrehozása volt, amely tökéletesen közvetíti a csapat mérnöki kiválóságát, a versenyzés és a high-tech telemetria világát.

== 1.1 Fő tervezési alapelvek
1. *Kivételes teljesítmény (Zero Heavy Frameworks):* A weboldal szándékosan keretrendszerek (React, Vue, Angular) nélkül, tiszta Vanilla JavaScript (ES modulok) és HTML5 alapon készült. Ez minimális bundle méretet, azonnali betöltést és stabil 60 FPS animációkat garantál még gyengébb mobil eszközökön is.
2. *Erőteljes versenyzői vizuális identitás:* Sötét háttérrendszer (`#0b0c10`), elektromos kék akcentusok (`#29aae1`, `#60c5f1`), döntött elemek (`-skew-x-12`), telemetriai HUD keretek és fénylő neon effektek.
3. *Kétnyelvű többoldalas architektúra (HU / EN):* Teljes körű magyar és angol tartalom különálló statikus belépési pontokkal (`/` és `/en/`), dinamikus nyelvi váltóval.
4. *Valódi 3D Telemetriai Megjelenítő:* Az `ERMe-01` versenyautó valósághű, 360 fokban forgatható, nagyítható 3D CAD modellje a weboldalba ágyazva.
5. *Karbantarthatóság bárki számára:* A csapattagok adatai egyetlen könnyen kezelhető CSV fájlból (`team.csv`), a szponzorok adatai pedig egy strukturált JSON fájlból (`sponsors.json`) töltődnek be, így programozói tudás nélkül is frissíthetők.

#callout(title: "FONTOS ALAPELV A JÖVŐBELI FEJLESZTŐKNEK")[
  A weboldal kódjának bővítése során tartsuk meg a *Vanilla JS + CSS* alapú architektúrát. Ne telepítsünk nehéz frontend keretrendszereket, mert a projekt ereje a közvetlen DOM manipulációban, a hardveres gyorsításban és a minimális hálózati terhelésben rejlik.
]

#v(0.5cm)

// ═══════════════════════════════════════════════════════════════════════════════
// 2. TECHNOLÓGIAI STACK ÉS ESZKÖZÖK
// ═══════════════════════════════════════════════════════════════════════════════

= 2. Technológiai Stack és Eszközkészlet

A projekt modern iparági standard eszközökre épül:

#table(
  columns: (1.2fr, 1.2fr, 2.6fr),
  fill: (col, row) => if row == 0 { erm-blue.lighten(90%) } else if calc.odd(row) { rgb("#f9fafb") } else { white },
  stroke: 0.5pt + erm-border,
  align: (left, left, left),
  table.header(
    [*Komponens*], [*Technológia*], [*Szerepe és funkciója a rendszerben*]
  ),
  [Építőeszköz (Bundler)], [Vite 8.3], [Szupergyors dev szerver Hot Module Replacement-tel (HMR), és Rollup alapú production build.],
  [Stílusrendszer], [Tailwind CSS v4], [A legújabb CSS-first Tailwind, `@theme` blokkban definiált változókkal, JIT optimalizálással.],
  [Logika], [Vanilla JavaScript (ESM)], [Natív böngésző modulok, aszinkron betöltés (`async/await`), `IntersectionObserver`.],
  [3D Renderelő Motor], [Three.js (WebGL)], [PBR anyagok, ACES Filmic Tone Mapping, OrbitControls kamera, vetett árnyékok.],
  [3D Tömörítő Dekóder], [Draco WASM], [Google Draco hálótömörítés dekódolása WebAssembly szálon a 983 KB-os modellhez.],
  [Típus és Tipográfia], [Google Fonts], ['Rajdhani' (félkövér technikai címek) és 'Inter' (folyó szöveg).],
  [Ikonok és Grafikák], [Inline SVG], [Nincs külső ikoncsomag; éles, skálázható és CSS-sel színezhető natív vektorok.]
)

#v(0.5cm)

// ═══════════════════════════════════════════════════════════════════════════════
// 3. FÁJLSTRUKTÚRA ÉS KÖNYVTÁRHIEARCHIA
// ═══════════════════════════════════════════════════════════════════════════════

= 3. Fájlstruktúra és Könyvtárhiearchia

A projekt forráskódja áttekinthető, moduláris szerkezetet követ:

```
ermiskolc-web/
├── index.html                   # Magyar nyelvű főoldal (belépési pont)
├── en/
│   └── index.html               # Angol nyelvű főoldal
├── src/
│   ├── main.js                  # Fő JavaScript logika (vezérlők, 3D, CSV, JSON)
│   └── style.css                # Globális CSS, Tailwind v4 @theme, animációk
├── public/                      # Statikus állományok (a Vite változtatás nélkül másolja)
│   ├── data/
│   │   ├── team.csv             # Kétnyelvű csapat adatbázis (8 egység)
│   │   └── sponsors.json        # 5 szintű szponzori lista hivatalos linkekkel
│   ├── documents/
│   │   ├── Szponzoranyag.pdf    # Magyar támogatói katalógus
│   │   └── Sponsorship_material.pdf # Angol támogatói katalógus
│   ├── draco/                   # Draco WASM dekódoló könyvtár (Three.js)
│   │   ├── draco_decoder.wasm
│   │   ├── draco_decoder.js
│   │   └── draco_wasm_wrapper.js
│   ├── model/
│   │   └── ERMe01-optimized.glb # Tömörített 3D CAD versenyautó modell
│   ├── img/
│   │   ├── logo.png / full-fehér2.2.png # Csapat logók
│   │   ├── feature_img1..6.webp # Formula Student galéria fotók
│   │   ├── team/                # Csapattagok portréi (.webp) + team.png
│   │   └── sponsors/            # Szponzor logók kategóriánként (diamond..partner)
│   └── video/
│       └── erm-video-compressed.mp4 # Hero drónfelvétel és műhely videó
├── documentation/               # Typst forrás és generált PDF dokumentáció
├── package.json                 # Függőségek és npm scriptek
└── vite.config.js               # Vite & Tailwind multi-page konfiguráció
```

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// 4. DESIGN RENDSZER ÉS STÍLUS (TAILWIND CSS V4)
// ═══════════════════════════════════════════════════════════════════════════════

= 4. Design Rendszer és Vizuális Nyelv

A weboldal stílusvilága a telemetria képernyők és a Formula Student depók hangulatát ötvözi.

== 4.1 Színpaletta (Tailwind v4 `@theme`)
A színek közvetlenül a `src/style.css` fájl `@theme` direktívájában vannak definiálva:

#grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  rect(fill: erm-dark, inset: 12pt, radius: 4pt, stroke: 1pt + erm-blue)[
    #text(weight: "bold", fill: white, size: 9pt)[SÖTÉT ALAPRENDSZER]\
    #v(3pt)
    #text(size: 8pt, fill: rgb("#9ca3af"))[
      • Deep Dark: `#0b0c10` (Fő háttér)\
      • Dark Gray: `#1f2833` (Kártyák és felületek)\
      • Text White: `#ffffff` (Főcímek)\
      • Text Muted: `#9ca3af` (Bekezdések)
    ]
  ],
  rect(fill: erm-dark, inset: 12pt, radius: 4pt, stroke: 1pt + erm-blue)[
    #text(weight: "bold", fill: erm-blue, size: 9pt)[ELEKTROMOS KÉK HANGSÚLYOK]\
    #v(3pt)
    #text(size: 8pt, fill: rgb("#9ca3af"))[
      • Primary Blue: `#29aae1` (Gombok, ikonok, HUD)\
      • Light Blue: `#60c5f1` (Glow és gradiensek)\
      • Hover Shadow: `rgba(41, 170, 225, 0.65)`\
      • Telemetry Accent: `rgba(56, 189, 248, 0.9)`
    ]
  ]
)

== 4.2 A Döntött Geometria Szabálya (`-skew-x-12`)
A dinamizmus és a sebességérzet érdekében a gombok, fülek, telemetria kártyák és elválasztók -12 fokos dőlésszöget (`transform: skewX(-12deg)`) kaptak.

#callout(title: "ARANY SZABÁLY: AZ OLVASHATÓ TIPOGRÁFIA MEGŐRZÉSE")[
  Ha egy szülő konténer `-skew-x-12` osztályt kap, a benne lévő szöveges gyermek elemet kötelező egy belső `<span>` elembe csomagolni `skew-x-12 inline-block` osztállyal. Ez kompenzálja a döntést a betűkön, így a gomb rombusz alakú marad, miközben a szöveg tökéletesen függőleges és kristálytisztán olvasható!
]

```html
<!-- Mintakód: Döntött gomb álló felirattal -->
<a href="#kapcsolat" class="btn-primary">
  <span class="inline-block skew-x-12">Ismerd meg az autót</span>
</a>
```

== 4.3 Rombusz Alakú Nyelvválasztó Kapcsoló
A navigációs sávban lévő `HU / EN` váltó gomb egy precíziós mechanikus billenőkapcsolót mintáz:
- A külső keret (`.lang-switcher`) sötét, finom belső árnyékkal ellátott rombusz (`-skew-x-12`).
- Az aktív nyelv kiemelése (`.lang-switcher-btn.active`) közvetlenül a szülő dőlésszögét örökli, így egy párhuzamos élű, világító kék rombusz jön létre.
- A feliratok belső inverz döntéssel függőlegesen állnak.

== 4.4 Lebegő "Vissza a Tetejére" Gomb
A jobb alsó sarokban egy rejtett technikai rombusz gomb (`.back-to-top`) helyezkedik el:
- Csak 400 képpontos lefelé görgetés után úszik be alulról (`.visible` osztály).
- Hover esetén intenzív neon aurát kap, az irányjelző nyíl pedig diszkréten felfelé animál.
- Kattintásra simított görgetéssel viszi vissza a látogatót az oldal tetejére (`window.scrollTo`).

== 4.5 Sleek Preloader és Villogásmentes Betöltés (Anti-FOUC)
Az első betöltés során a weboldalak gyakori problémája a stílus nélküli tartalom villanása (Flash of Unstyled Content – FOUC), amikor a böngésző a CSS csomagok és betűkészletek letöltése előtt a natív, nyers fehér háttérrel rendereli az elemeket.

Ennek kiküszöbölésére és a prémium Formula Student versenyszellem átadására egy integrált boot-up preloader animációt implementáltunk:
1. *Kritikus beágyazott stílusok (`<head>` inline CSS):* Az alap háttérszín (`#0b0c10`) és a `#page-preloader` azonnal, külső hálózati kérések megvárása nélkül érvényesül a legelső megjelenítéskor (First Paint).
2. *Motorsport Telemetria Animáció:*
   - Középen elhelyezett ERM logó lélegző kék neon aurával (`filter: drop-shadow`).
   - -12 fokban döntött (`-skew-x-12`) rombusz töltősáv folyamatosan pásztázó kék-cián fénycsíkkal.
   - Villogó állapotjelző LED és státuszfelirat (`RENDSZER INICIALIZÁLÁSA` / `SYSTEM INITIALIZING`).
3. *Simított feloldás és Erőforrás-felszabadítás:*
   - Amikor a teljes ablak (`window.load`) készen áll, minimum 500 ms elegáns megjelenítés után a preloader lágyan átlátszóvá válik (`opacity: 0, visibility: hidden`).
   - Az átmenet befejeztével a JavaScript eltávolítja az elemet a DOM-ból (`preloaderEl.remove()`), felszabadítva a memóriát.
   - *Biztonsági időzítő (Failsafe Timeout):* Egy beépített 2.5–3 másodperces időzítő garantálja, hogy egy lassú hálózat vagy akadozó külső kérés esetén se maradhasson zárolva az oldal.

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// 5. RÉSZLETES MODUL- ÉS FUNKCIÓBEMUTATÁS
// ═══════════════════════════════════════════════════════════════════════════════

= 5. Részletes Modul- és Funkcióbemutatás

== 5.1 Hero Szekció (Videóháttér és Részecskerendszer)
A nyitó képernyő 100vh magasságú, több rétegű kompozíció:
1. *Videó háttér:* `/video/erm-video-compressed.mp4` – natív HTML5 `<video>` elem, amely némítva, végtelenítve fut, optimális (68%-os) láthatósággal.
2. *Dinamikus Canvas Részecskerendszer:* Egy könnyűsúlyú HTML5 2D vászon, amelyen apró kék részecskék lebegnek és bizonyos közelségnél vékony elektromos adatvonalakkal kapcsolódnak össze. Az erőforrások kímélése érdekében az animáció leáll, ha a Hero szekció kikerül a képernyőről.

== 5.2 Az FS-ről (Formula Student Információ és Galéria)
A nemzetközi versenysorozatot bemutató rész két interaktív oszlopra oszlik:
- *Bal oldal:* Interaktív harmonika (Verseny, Statikus számok, Dinamikus számok, Csapatmunka), zökkenőmentes CSS max-height átmenettel.
- *Jobb oldal:* Érintésérzékeny (touch-swipe) és kattintható képgaléria karusszel:
  - Automatikus váltás 4 másodpercenként (amely hover vagy érintés esetén szünetel).
  - Telemetriai számláló (`01 / 06`) és navigációs pontok.

== 5.3 ERMe-01 és a 3D WebGL Telemetria Munkaállomás
A weboldal egyik legfontosabb mérnöki eleme az autó bemutatása:
- *3D WebGL Modellnézegető:*
  - A modell a `/public/model/ERMe01-optimized.glb` fájlból töltődik be.
  - A betöltést a Three.js és a Draco WebAssembly dekódoló (`/public/draco/`) végzi.
  - Automatikus befoglaló méret (Bounding Box) számítás: az autó mérettől függetlenül pontosan a virtuális lemezjátszó padlójának közepére kerül, a kamera pedig optimális távolságba áll be.
  - Elektromos kék stúdió megvilágítás és körkörös neon talpfény.
  - HUD vezérlők: *Forgatás ki/be kapcsolása* és *Nézet alaphelyzetbe állítása*.
  - *Hardverkímélő IntersectionObserver:* A Three.js renderelési ciklusa (`requestAnimationFrame`) automatikusan felfüggesztődik, ha a szekció nincs a képernyőn!
- *Telemetriai Dashboard Kártyák:*
  - Fő adatok (Tömeg: 220 kg, Teljesítmény: 80 kW, 0–100 km/h: 3.5 mp, Végsebesség: 130 km/h) számláló animációval (`data-target`).
  - Műszaki részletek (Akkumulátor, Hajtáslánc, Real-Time CAN-bus telemetria).

== 5.4 Csapatunk (Csapatfotó és Dinamikus CSV Rendszer)
A csapat szekció két fő vizuális rétegből áll:
1. *Nagyméretű Csapatfotó Banner:* A legfrissebb közös fotó (`/img/team/team.png`) high-tech sarokkeretekkel és 2026-os szezonjelvénnyel.
2. *Interaktív Csapatnévsor:* A névsor a `/public/data/team.csv` fájlból generálódik.

#callout(title: "A CSAPATUNK SZEKCIÓ 8 HIVATALOS EGYSÉGE")[
  A szűrőfülek a látogató választott nyelvének megfelelően automatikusan megjelennek a kért sorrendben:
  #v(4pt)
  #grid(
    columns: (1fr, 1fr),
    [
      *Magyar változat:*
      1. Mind (Összes megjelenítése)
      2. Management
      3. Elektronikai egység
      4. Gépész egység
      5. IT egység
      6. HR és Jogi egység
      7. Marketing egység
      8. Pénzügyi egység
      9. Alumni tagjaink
    ],
    [
      *Angol változat:*
      1. All (Show all members)
      2. Management
      3. Electronics Unit
      4. Mechanical Unit
      5. IT Unit
      6. HR & Legal Unit
      7. Marketing Unit
      8. Finance Unit
      9. Alumni Members
    ]
  )
]

== 5.5 Szponzoraink (5 Szint, Csillogó Sheen Effekt & Valós Linkek)
A szponzorok a `/public/data/sponsors.json` fájl alapján 5 különálló szinten jelennek meg:
- *Alapértelmezett állapot:* Valamennyi szponzorlogó egységes, elegáns fehér megjelenést kap (`brightness(0) invert(1)`), garantálva a tiszta, professzionális összképet.
- *Interaktív kategória-specifikus csillogás (Sheen Sweep):*
  - *Gyémánt (Diamond):* Jéghideg elektromos kék és cián csillanás + cián aura.
  - *Arany (Gold):* Meleg aranyló fénysugár + aranyfényű logó pulzálás.
  - *Ezüst (Silver):* Tiszta platina króm fénycsík + ezüst keret ragyogás.
  - *Bronz (Bronze):* Gazdag meleg borostyán/bronz csillanás + bronz aura.
  - *Partner:* High-tech elektromos kék pásztázás.
- *Valós linkek:* Valamennyi logó a cég hivatalos weboldalára mutat új lapon (`target="_blank"`).

== 5.6 Gyakran Ismételt Kérdések (GYIK)
Tíz kártyából álló kérdezz-felelek blokk a jelentkezésről, a Formula Student követelményeiről és a csatlakozási lehetőségekről.

== 5.7 Műhely Elhelyezkedés és Térkép Integráció
A Miskolci Egyetem Műszaki Karának műhelyépületét (`48.083451, 20.766736`) bemutató blokk, sötétített OpenStreetMap/Google Maps navigációs beágyazással és egykattintásos útvonaltervező gombbal.

== 5.8 Lábléc és Szponzori Anyagok Letöltése
A lábléc közvetlen hozzáférést biztosít a támogatói PDF katalógusokhoz:
- Magyar oldalon: `#link("/documents/Szponzoranyag.pdf")[Szponzoranyag.pdf]`
- Angol oldalon: `#link("/documents/Sponsorship_material.pdf")[Sponsorship_material.pdf]`

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// 6. ADATBÁZISOK ÉS ADATKEZELÉSI ÚTMUTATÓ
// ═══════════════════════════════════════════════════════════════════════════════

= 6. Adatkezelési Kézikönyv Csapattagoknak

A weboldal legnagyobb előnye, hogy a leggyakrabban változó tartalmakhoz (új csapattagok, pozícióváltások, új szponzorok) *nem kell a JavaScript kódhoz nyúlni*.

== 6.1 A Csapattagok Frissítése (`public/data/team.csv`)
A fájl egy egyszerű, szabványos UTF-8 kódolású CSV állomány.

=== Fejlécek felépítése:
```csv
name,role_hu,role_en,department_hu,department_en,image
```

#table(
  columns: (1fr, 1.2fr, 2.8fr),
  fill: (col, row) => if row == 0 { erm-blue.lighten(90%) } else if calc.odd(row) { rgb("#f9fafb") } else { white },
  stroke: 0.5pt + erm-border,
  align: (left, left, left),
  table.header([*Mező*], [*Példa érték*], [*Leírás és elvárások*]),
  [`name`], [Béla Dániel], [A csapattag teljes neve.],
  [`role_hu`], [Csapatvezető], [Pozíció megnevezése magyarul.],
  [`role_en`], [Team Leader], [Pozíció megnevezése angolul.],
  [`department_hu`], [Management], [A fenti 8 hivatalos egység egyike magyarul.],
  [`department_en`], [Management], [A fenti 8 hivatalos egység egyike angolul.],
  [`image`], [BélaD.webp], [A fotó fájlneve a `/public/img/team/` mappában. Ha üres, automatikusan a `Blank.webp` jelenik meg.]
)

=== Példa sorok a CSV-ből:
```csv
Béla Dániel,Csapatvezető,Team Leader,Management,Management,BélaD.webp
Ercse Gergő,Elektronikai egységvezető,Head of Electronics,Elektronikai egység,Electronics Unit,ErcseG.webp
Tóth Erik,Gépész egységvezető,Head of Mechanics,Gépész egység,Mechanical Unit,TóthE.webp
Koba Márk,IT egységvezető,Head of IT & Software,IT egység,IT Unit,KobaM.webp
Kovács Péter,Korábbi csapatvezető,Former Team Leader,Alumni tagjaink,Alumni Members,Blank.webp
```

== 6.2 A Szponzorok Frissítése (`public/data/sponsors.json`)
A támogatók szintenként csoportosítva találhatók a JSON fájlban:

```json
{
  "tiers": [
    {
      "name": "Gyémánt",
      "id": "diamond",
      "sponsors": [
        {
          "name": "Altium",
          "logo": "/img/sponsors/diamond/altium.webp",
          "url": "https://altium.com/"
        }
      ]
    }
  ]
}
```

#callout(title: "ÚJ SZPONZOR HOZZÁADÁSA 3 LÉPÉSBEN")[
  1. Helyezd el a szponzor logóját a megfelelő alkönyvtárba: `/public/img/sponsors/{diamond|gold|silver|bronze|partner}/cegnev.webp`. (Preferált formátum: átlátszó hátterű WebP vagy PNG).
  2. Nyisd meg a `public/data/sponsors.json` fájlt, és a kívánt kategóriához szúrj be egy új bejegyzést a névvel, a logó relatív elérési útjával és a weboldal URL-jével.
  3. Mentsd el a fájlt. A változás az oldalon azonnal érvénybe lép, felveszi a kategória csillogását és a kattintható linket!
]

#pagebreak()

// ═══════════════════════════════════════════════════════════════════════════════
// 7. FEJLESZTŐI ÉS ÜZEMELTETÉSI ÚTMUTATÓ
// ═══════════════════════════════════════════════════════════════════════════════

= 7. Fejlesztői és Üzemeltetési Útmutató

== 7.1 Előfeltételek
- *Node.js:* v18.0.0 vagy újabb (ajánlott: v20+ LTS).
- *Csomagkezelő:* npm (beépített a Node.js-be).

== 7.2 Helyi Fejlesztői Környezet Indítása
A projekt gyökérkönyvtárában nyissunk egy terminált:

```bash
# Függőségek telepítése (első alkalommal)
npm install

# Helyi fejlesztői szerver indítása Hot Reload funkcióval
npm run dev

# Hálózati eléréssel (mobilos teszteléshez a helyi Wi-Fi-n)
npx vite --host
```
A szerver alapértelmezetten a `http://localhost:5173/` vagy `http://localhost:5174/` címen érhető el.

== 7.3 Éles Verzió Fordítása (Production Build)
A statikus production kód legenerálásához futtassuk:

```bash
npm run build
```
A parancs létrehozza a `dist/` mappát, amely az alábbi optimalizációkat tartalmazza:
- HTML tömörítés és minifikálás.
- CSS fa-rázás (Tree-shaking) és minifikálás a Tailwind v4 által.
- JavaScript kódcsomagolás és aszinkron chunkolás (a Three.js külön csomagban töltődik be).
- A statikus dokumentumok, 3D modellek és WebAssembly dekódolók automatikus átmásolása.

== 7.4 Telepítés Éles Webszerverre (Apache / Nginx / Vercel)
Mivel a projekt tisztán statikus weboldal, bármilyen szabványos webszerveren futtatható. Egyszerűen másoljuk át a `dist/` mappa tartalmát a webszerver dokumentum gyökerébe (`public_html` vagy `/var/www/html`).

=== Kritikus MIME-típus beállítások:
Ügyeljünk rá, hogy a webszerver a következő kiterjesztéseket a megfelelő MIME-fejléccel szolgálja ki:
- `.wasm` $->$ `application/wasm` (a Draco 3D dekódoló zökkenőmentes működéséhez).
- `.glb` $->$ `model/gltf-binary` (a 3D versenyautó modellhez).
- `.webp` $->$ `image/webp`.

#v(0.5cm)

// ═══════════════════════════════════════════════════════════════════════════════
// 8. ÖSSZEGZÉS ÉS KAPCSOLAT
// ═══════════════════════════════════════════════════════════════════════════════

= 8. Összegzés és Elérhetőségek

Az új Electric Racing Miskolc weboldal a legmodernebb webes technológiákat ötvözi a kompromisszummentes mérnöki szemlélettel. A tiszta kód, a keretrendszer-mentes architektúra és az önálló adatfájlok biztosítják, hogy a platform éveken át gyors, megbízható és könnyen frissíthető maradjon a csapat jövőbeli tagjai számára is.

#v(0.5cm)

#rect(
  fill: erm-dark,
  inset: 16pt,
  radius: 6pt,
  stroke: 1pt + erm-blue
)[
  #text(weight: "bold", size: 11pt, fill: erm-blue)[ELECTRIC RACING MISKOLC]\
  #v(4pt)
  #text(size: 9pt, fill: rgb("#d1d5db"))[
    *Műhely & Székhely:* Miskolci Egyetem, 3515 Miskolc-Egyetemváros (Műszaki Kar)\
    *Weboldal:* https://ermiskolc.hu\
    *Email:* sponsor.erm\@gmail.com\
    *Közösségi média:* facebook.com/ermiskolc • instagram.com/ermiskolc
  ]
]

#v(1cm)
#align(center)[
  #text(size: 8.5pt, fill: rgb("#9ca3af"), style: "italic")[
    Dokumentáció lezárva: 2026. október • Electric Racing Miskolc Formula Student Team
  ]
]
