# Hidden Spots — Design Guide & UX Direction

> Objectif : créer une app iOS avec un effet "wow" immédiat, super facile à utiliser, et visuellement aspirante.

---

## 1. Direction visuelle

**Concept** : L'interface doit disparaître devant le contenu. Hidden Spots est une app photo : les images sont les héros, l'UI est minimaliste et fonctionnelle.

**Mood** : Aspirational, minimal, chaleureux, premium.

**Inspirations** :
- **Airbnb** : carte + fiches coordonnées, navigation fluide.
- **Apple Photos** : transitions hero, parallax, scrolling naturel.
- **Google Maps** : contexte principal (carte) jamais perdu.
- **VSCO / Unsplash** : images plein écran, UI qui se fond.

**Principe directeur** : *"Chaque écran doit faire envie d'aller là-bas."*

---

## 2. Principes UX

### 2.1 Clarté avant tout
- Une action principale par écran.
- Pas de menus hamburger pour les features core.
- Texte court, icônes SF Symbols standard.

### 2.2 Navigation au pouce
- Tab bar en bas avec 3 onglets max.
- Actions principales dans la moitié inférieure de l'écran.
- Bottom sheet pour les détails de spot (comme Apple Maps).

### 2.3 Feedback immédiat
- Haptic sur favori, sauvegarde, téléchargement.
- Animation de transition < 300ms.
- Skeleton screens au lieu de spinners.

### 2.4 Onboarding progressif
- Pas de tutoriel upfront.
- 3 écrans d'onboarding visuels max.
- Guest mode possible (pas de signup obligatoire).
- Permissions demandées en contexte ("Allow location to find spots near you").

### 2.5 Offline-first
- Tout le contenu téléchargé doit s'afficher instantanément.
- Mode offline clairement indiqué.
- Pas d'écran blanc si pas de réseau.

---

## 3. Design System

### 3.1 Palette de couleurs

```
Primary Accent     : #FF8C42 (Golden Hour Orange)
Primary Dark       : #E67A36
Secondary Accent   : #2EC4B6 (Teal — pour "go", "open map")
Background Light   : #FAFAFA
Background Dark    : #0F0F0F
Surface Light      : #FFFFFF
Surface Dark       : #1C1C1E
Text Primary       : #1A1A1A / #FFFFFF
Text Secondary     : #6B7280 / #A1A1AA
Success            : #34C759
Premium            : #FFD700 (Gold)
```

**Règles** :
- L'accent orange est utilisé avec parcimonie : boutons CTA, highlights, badges premium.
- Les photos gardent des couleurs naturelles. Pas de filtre global sur l'UI.
- Mode sombre par défaut ou option ? Recommandation : respecter le système, mais optimiser les deux.

### 3.2 Typographie

Utiliser **SF Pro** (police système iOS).

| Style | Taille | Poids | Usage |
|---|---|---|---|
| Large Title | 34 pt | Bold | Titre ville / écran d'accueil |
| Title 1 | 28 pt | Bold | Nom du spot |
| Title 2 | 22 pt | Semibold | Section headers |
| Headline | 17 pt | Semibold | Boutons, chips |
| Body | 17 pt | Regular | Descriptions |
| Callout | 16 pt | Medium | Infos secondaires |
| Subheadline | 15 pt | Regular | Tips, métadonnées |
| Caption | 12 pt | Medium | Labels, exifs |

### 3.3 Composants principaux

#### Bottom Navigation (4 onglets en V2)

**MVP (3 onglets)** :
```
[Map]  [Spots]  [Profile]
```

**V2+ (4 onglets)** :
```
[Map]  [Spots]  [Challenges]  [Profile]
```

- Icônes SF Symbols : `map.fill`, `photo.stack.fill`, `trophy.fill`, `person.fill`
- Labels sous les icônes.
- Barre translucide avec blur.
```
[Map]  [Spots]  [Profile]
```
- Icônes SF Symbols : `map.fill`, `photo.stack.fill`, `person.fill`
- Labels sous les icônes.
- Barre translucide avec blur.

#### Spot Card (dans la liste)
- Image carrée/rectangulaire arrondie.
- Titre + catégorie + badge distance.
- Badge premium en haut à droite.
- Tap → fiche détaillée.

#### Bottom Sheet (fiche spot)
- S'ouvre à 40% de l'écran, draggable à 90%.
- Header avec handle gris.
- Photo hero en haut.
- Infos clés en chips.
- Bouton "Get directions" fixé en bas.

#### Filter Chips
- Capsules arrondies.
- État actif : fond orange, texte blanc.
- État inactif : fond gris clair, texte sombre.

#### Premium Badge
- Couronne dorée + texte "Premium".
- Utilisé sur les spots payants.

#### Paywall Sheet
- Fond flouté (glassmorphism).
- Titre clair : "Unlock 45 hidden spots in Lisbon".
- Deux boutons : monthly / annual (annual mis en avant).
- Liste des avantages avec checkmarks.

---

## 4. Écrans détaillés

### 4.1 Splash + Onboarding

**Splash**
- Logo "Hidden Spots" centré.
- Animation subtile de fade-in.
- Durée : 1.5s max.

**Onboarding (3 écrans)**
1. **Discover** — photo plein écran d'un spot incroyable.
   - "Find the best photo spots in every city."
2. **Plan** — mockup d'un itinéraire optimisé.
   - "Plan your shoots around light and crowds."
3. **Capture** — photo avant/après.
   - "Never miss the perfect shot again."

- CTA final : "Start exploring" (guest mode) ou "Sign in with Apple".
- Pas de swipe obligatoire, dots indicator en bas.

### 4.2 Home / Map Screen

**Structure**
```
┌─────────────────────────┐
│ [Search bar flottante]  │
│                         │
│      MAP VIEW           │
│      (full screen)      │
│                         │
│                         │
├─────────────────────────┤
│ [City picker segmenté]  │
│ [Category chips]        │
│ [Bottom nav]            │
└─────────────────────────┘
```

**Interactions**
- Tap sur un marker → bottom sheet spot s'ouvre.
- Pan sur la carte → fiche se ferme.
- City picker change la région de la carte.
- Search bar flottante en haut avec glassmorphism.

### 4.3 Spots List Screen

**Structure**
```
┌─────────────────────────┐
│ Hidden Spots            │
│ [City picker]           │
│ [Filter chips scroll]   │
│ ┌─────┐ ┌─────┐         │
│ │Spot │ │Spot │ ...     │
│ │Card │ │Card │         │
│ └─────┘ └─────┘         │
│                         │
│ [Bottom nav]            │
└─────────────────────────┘
```

**Spot Card**
- Image 16:9 avec coins arrondis.
- Overlay dégradé en bas avec nom + catégorie.
- Badge premium en haut à droite.
- Distance depuis l'utilisateur (si localisation autorisée).

### 4.4 Spot Detail Screen

**Bottom sheet draggable**
```
┌─────────────────────────┐
│ ─────                   │  <- handle
│ [Photo hero 16:9]       │
│ NOM DU SPOT        👑   │
│ Ville, Pays             │
│                         │
│ [🌅 Sunset] [👥 Local]   │
│ [🚶 Easy] [⏰ 18:42]     │
│                         │
│ About                   │
│ Description du spot...  │
│                         │
│ Photographer Tips       │
│ Conseils pratiques...   │
│                         │
│ [Get directions]        │
│ [Save] [Share]          │
└─────────────────────────┘
```

**Wow features**
- Hero transition depuis la carte/liste.
- Parallax sur la photo hero quand on scroll.
- Bouton "Copy exact GPS".
- Golden hour countdown visuel.

### 4.5 Profile / Settings

**Structure**
```
┌─────────────────────────┐
│ Profile                 │
│ [Avatar] Name           │
│                         │
│ Premium Member / Free   │
│ [Upgrade button]        │
│                         │
│ Saved Lists             │
│ Downloaded Cities       │
│ Settings                │
│ - Dark mode             │
│ - Notifications         │
│ - Language              │
│                         │
│ [Bottom nav]            │
└─────────────────────────┘
```

### 4.6 Paywall

**Design**
- Fond avec photo de spot premium floutée.
- Glassmorphism card au centre.
- Titre : "Unlock every hidden spot".
- Prix mensuel / annuel en toggle.
- Annual mis en avant avec badge "Save 50%".
- Liste avantages avec animations stagger.
- CTA principal : "Start free trial".
- Petit texte : "Cancel anytime".

### 4.7 Gamification Screens

#### Profile / Progression
```
┌─────────────────────────┐
│ Profile                 │
│ [Avatar] Name           │
│ Light Chaser  ▓▓▓▓▓░░░  │
│ 1,240 SP                │
│                         │
│ 🏅 Badges (12/45)       │
│ 🔥 Active Week Streak: 3│
│ 📸 Spots visited: 24    │
│                         │
│ My Album                │
│ [grid of photos]        │
│                         │
│ [Bottom nav]            │
└─────────────────────────┘
```

#### Badge Unlocked Celebration
- Full-screen modal avec badge animé.
- Titre : "Badge Unlocked".
- Nom du badge + description.
- Bouton "Share" et "Continue".
- Confetti subtil + haptic success.

#### Level Up Screen
- Animation de la barre de progression qui se remplit.
- Nouveau titre et badge affichés.
- Récompenses débloquées listées.
- CTA : "Explore new spots".

#### Challenges Feed
- Cartes de challenges avec image thématique.
- Countdown, nombre de participants, prix.
- Bouton "Join Challenge".
- Leaderboard temporaire accessible en tap.

---

## 5. Micro-interactions & animations

### 5.1 Must-have

| Interaction | Animation | Durée |
|---|---|---|
| Tap favori | Cœur scale + haptic | 200ms |
| Sélection spot | Hero transition vers fiche | 300ms |
| Pull-to-refresh | Logo qui tourne | 400ms |
| Téléchargement ville | Progress ring + check | 600ms |
| Filtre sélectionné | Chip scale + couleur | 150ms |
| Marker tap | Bounce + scale | 200ms |
| Premium unlock | Confetti subtil + haptic success | 500ms |
| Scroll fiche spot | Parallax photo + titre shrink | continuous |

### 5.2 Principes d'animation

- **Toujours < 500ms** pour ne pas ralentir l'utilisateur.
- **Easing naturel** : `easeInOut` ou `spring`.
- **Respecter `prefersReducedMotion`**.
- **Chaque animation a un but** : feedback, orientation, ou delight.

### 5.3 Haptic feedback

- Light impact : tap sur chip, sélection.
- Medium impact : sauvegarde, favori.
- Success : achat premium, téléchargement terminé.
- Error : action impossible, offline.

---

## 6. Dark Mode

**Palette sombre**
- Fond : #0F0F0F
- Surface : #1C1C1E
- Texte : #FFFFFF / #A1A1AA
- Accent : même orange (#FF8C42) mais légèrement moins saturé.

**Règles**
- Photos conservent leur luminosité.
- Pas de fond purement noir (#000000) pour éviter le contraste trop fort.
- Ombres remplacées par des bordures subtiles.

---

## 7. Accessibilité

- **Taille de touche** : minimum 44×44 pt.
- **Contraste** : ratio 4.5:1 minimum pour le texte.
- **Dynamic Type** : support des tailles de texte système.
- **VoiceOver** : labels sur tous les boutons et images.
- **Reduced Motion** : désactiver les parallaxes et confettis.
- **Alt text** : descriptions des photos exemples.

---

## 8. Références concurrentes à étudier

| App | Ce qu'on apprend |
|---|---|
| **Airbnb** | Intégration carte + fiches, navigation sans perte de contexte |
| **Google Maps** | Transitions explore/navigate, info density maîtrisée |
| **Apple Photos** | Hero transitions, parallax, scrolling fluide |
| **VSCO** | Minimalisme, images en héros, presets |
| **Unsplash** | Grids photo, immersion, recherche visuelle |
| **Hopper** | Réduire les données complexes à une recommandation claire |

---

## 9. Checklist design avant lancement

- [ ] App ouvre en < 2s.
- [ ] Onboarding terminable en 15s.
- [ ] Premier spot visible en 3 taps max.
- [ ] Paywall clair et pas agressif.
- [ ] Dark mode testé.
- [ ] VoiceOver testé sur 3 écrans.
- [ ] Animations fluides à 60fps.
- [ ] Aucun texte tronqué en Dynamic Type max.
- [ ] Touch targets ≥ 44×44 pt.
- [ ] Mode offline testé.

---

## 11. Gamification

La gamification est intégrée progressivement dans l'expérience. Voir le guide détaillé :
**GAMIFICATION_DESIGN.md**

Points clés UX :
- Shutter Points (SP) gagnés en visitant des spots réellement.
- Niveaux de photographe avec progression visible.
- Badges par catégorie photo, ville et action.
- Streak hebdomadaire (pas quotidien) pour éviter la pression.
- Challenges photo communautaires.
- Leaderboards segmentés par ville/amis/semaine.

---

## 12. Ressources

- Apple Human Interface Guidelines : https://developer.apple.com/design/human-interface-guidelines
- SF Symbols : https://developer.apple.com/sf-symbols/
- Apple Design Resources (Figma) : https://developer.apple.com/design/resources/
- Color contrast checker : https://webaim.org/resources/contrastchecker/

---

**En résumé** : Hidden Spots doit être une app où l'utilisateur se sent guidé, inspiré, et récompensé. L'UI disparaît, les photos parlent, et chaque micro-interaction renforce la sensation de qualité premium.
