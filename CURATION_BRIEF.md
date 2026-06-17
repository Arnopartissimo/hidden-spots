# Hidden Spots — Brief de Curation

## Objectif

Créer un catalogue de spots photo de haute qualité, ville par ville. Chaque spot doit être **utile sur place** : coordonnées exactes, meilleure lumière, accès, conseils pratiques.

## Critères de sélection

Un spot Hidden Spots doit répondre à au moins 3 critères :

1. **Qualité visuelle** : le spot produit des photos fortes (composition, lumière, couleur).
2. **Accessibilité** : public ou accessible légalement (pas de spots privés interdits).
3. **Différenciation** : pas le spot touristique #1 sur TripAdvisor, sauf s'il y a un angle spécial.
4. **Info exploitable** : on peut indiquer l'heure idéale, la focale, l'accès.
5. **Sécurité** : pas de spot dangereux (toits interdits, falaises instables).

## Template de fiche spot

```json
{
  "name": "Nom du spot",
  "city": "Ville",
  "country": "Pays",
  "latitude": 0.0000,
  "longitude": 0.0000,
  "category": "sunset|sunrise|architecture|street|nature|portrait|food|rooftop|neon|skyline",
  "crowdLevel": 1-5,
  "accessDifficulty": "easy|moderate|hard|restricted",
  "bestTime": "Sunset / Sunrise / Blue hour / Night / Morning / Golden hour",
  "descriptionText": "2-3 phrases décrivant le spot et ce qu'on y photographie.",
  "tips": "Conseils pratiques : focale, angle, heure d'arrivée, restrictions, accessibilité.",
  "examplePhotoURLs": ["url1", "url2"],
  "isPremium": true|false
}
```

## 5 villes pilotes — spots de départ

### Lisbonne (Portugal)

| Spot | Catégorie | Crowd | Best time | Premium |
|---|---|---|---|---|
| Miradouro da Senhora do Monte | sunset | 2 | Sunset | Oui |
| Pink Street | street | 4 | Early morning | Non |
| LX Factory Rooftop | rooftop | 3 | Golden hour | Oui |
| Alfama rooftops from Largo das Portas do Sol | sunrise | 3 | Sunrise | Oui |
| MAAT from Belém riverside | architecture | 2 | Blue hour | Oui |

### Paris (France)

| Spot | Catégorie | Crowd | Best time | Premium |
|---|---|---|---|---|
| Trocadéro | architecture | 5 | Sunrise | Non |
| Rue Crémieux | street | 4 | Morning | Oui |
| Pont de Bir-Hakeim | architecture | 3 | Sunset | Oui |
| Montmartre vineyards | nature | 2 | Morning | Oui |
| La Défense from Pont de Neuilly | skyline | 2 | Blue hour | Oui |

### Tokyo (Japon)

| Spot | Catégorie | Crowd | Best time | Premium |
|---|---|---|---|---|
| Shibuya Sky | skyline | 4 | Blue hour | Oui |
| Omoide Yokocho | neon | 4 | Night | Non |
| TeamLab Planets reflections | architecture | 3 | Anytime | Oui |
| Yanaka Ginza cat street | street | 2 | Afternoon | Oui |
| Tokyo Metropolitan Gov Building south tower | skyline | 2 | Sunset | Oui |

### New York (USA)

| Spot | Catégorie | Crowd | Best time | Premium |
|---|---|---|---|---|
| DUMBO Manhattan Bridge | architecture | 5 | Sunrise | Non |
| Top of the Rock | skyline | 4 | Sunset | Oui |
| Greenwich Village townhouses | street | 2 | Morning | Oui |
| Brooklyn Heights Promenade | skyline | 3 | Blue hour | Oui |
| Times Square from above | neon | 5 | Night | Oui |

### Rome (Italie)

| Spot | Catégorie | Crowd | Best time | Premium |
|---|---|---|---|---|
| Gianicolo at sunrise | skyline | 2 | Sunrise | Oui |
| Trastevere alleys | street | 3 | Evening | Non |
| Colosseum from Via degli Annibaldi | architecture | 4 | Sunrise | Oui |
| Pincian Hill terrace | sunset | 3 | Sunset | Oui |
| Campo de' Fiori market | food | 4 | Morning | Oui |

## Processus de recherche par ville

### Étape 1 : Recherche brute (2-3h)
- Rechercher sur Instagram : `#lisbonphotography`, `#lisbonphotospots`, `#hiddenlisbon`
- Rechercher sur TikTok : "photo spots Lisbon", "hidden gems Lisbon"
- Lire 5-10 articles de blogs "best photo spots in Lisbon"
- Consulter Unsplash locations pour Lisbonne

### Étape 2 : Shortlist (30-45 min)
- Lister 30-40 candidats.
- Noter : nom, coordonnées approximatives, type photo, originalité.

### Étape 3 : Vérification (1-2h)
- Vérifier chaque coordonnée sur Google Maps / Street View.
- Confirmer l'accès public.
- Identifier le meilleur moment et l'angle.

### Étape 4 : Production (2-3h)
- Rédiger les descriptions et tips.
- Trouver/créer 3-5 photos exemples.
- Encoder en JSON.

### Étape 5 : Review
- Relire chaque fiche.
- Vérifier la cohérence des catégories.
- S'assurer qu'on a une variété (sunset, street, architecture, etc.).

## Outils recommandés

- **Google Maps / Street View** : vérification coordonnées et accès.
- **Sun Surveyor / PhotoPills** : calcul golden hour et direction du soleil.
- **Instagram / TikTok** : découverte des spots populaires.
- **Unsplash / Pexels** : photos libres de droit.
- **Notion / Airtable** : base de curation temporaire.
- **JSON formatter** : validation du fichier spots.json.

## Règles d'or

1. Mieux vaut 30 spots parfaits que 100 médiocres.
2. Toujours vérifier l'accès légalement.
3. Privilégier les spots où on peut donner un conseil concret.
4. Varier les catégories pour plaire à tous les photographes.
5. Mettre à jour les spots fermés ou devenus trop bondés.
