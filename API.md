## Cities

`GET /api/v1/cities`

```javascript
{
  cities: [
    {
      id: 1,
      name: "Paris",
      location: "Le Wagon",
      description: {
        fr: "En plein coeur du 11ème, à 100m du Métro Oberkampf. Vous travaillerez dans un incroyable Hacker Space de 600 m2 designé par 2 artistes des Beaux-Arts. Un des spots "tech" les plus sympas de Paris. Préparez-vous à plonger dans un univers où ça parle code & produit et où l'on concrétise ses idées ! ",
        en: "In the heart of Paris, close by the Oberkampf street, our 700 sq. m space welcome students and meetup apprentices! Be prepared to dive in a world of tech and startups! "
      },
      address: "16 Villa Gaudelet, 75011 Paris",
      latitude: 48.8648482,
      longitude: 2.3798534,
      location_picture: "http://path.jpg",
      city_picture: "http://path.jpg",
      meetup_id: 16766372,
      twitter_url: "https://twitter.com/Lewagonparis"
    },
    {
      id: 2,
      name: "Brussels",
      location: "Costation",
      description: {
        fr: "Nos cours, à Bruxelles, sont donnés en anglais dans les locaux de <a href='http://www.co-station.com/'>Co.Station</a>, un accélérateur de startups, situé au coeur de la ville, à deux minutes à pied de la Gare Centrale. ",
        en: "Our courses are taught in <strong>English</strong>, at <a href='http://www.co-station.com/'>Co.Station</a>, a startups accelerator located in the heart of Brussels, a ​2 minutes' ​walk ​from the city's Central Station. "
      },
      address: "Place Sainte-Gudule 5, 1000 Brussels",
      latitude: 50.8474433,
      longitude: 4.3591849,
      location_picture: "http://path.jpg",
      city_picture: "http://path.jpg",
      meetup_id: 16630202,
      twitter_url: "https://twitter.com/LewagonBrussels"
    }
  }
}
```

`GET /api/v1/cities/:city_slug` exemple `GET /api/v1/cities/paris`

```json
{
  city: {
    id: 1,
    name: "Paris",
    location: "Le Wagon",
    description: {
      fr: "En plein coeur du 11ème, à 100m du Métro Oberkampf. Vous travaillerez dans un incroyable Hacker Space de 600 m2 designé par 2 artistes des Beaux-Arts. Un des spots "tech" les plus sympas de Paris. Préparez-vous à plonger dans un univers où ça parle code & produit et où l'on concrétise ses idées ! ",
      en: "In the heart of Paris, close by the Oberkampf street, our 700 sq. m space welcome students and meetup apprentices! Be prepared to dive in a world of tech and startups! "
    },
    address: "16 Villa Gaudelet, 75011 Paris",
    latitude: 48.8648482,
    longitude: 2.3798534,
    location_picture: "http://wagon-alumni.s3.amazonaws.com/development/cities/location_pictures/000/000/001/cover/local-paris.jpg?1442595265",
    city_picture: "http://wagon-alumni.s3.amazonaws.com/development/cities/city_pictures/000/000/001/cover/paris.jpg?1442595266",
    meetup_id: 16766372,
    twitter_url: "https://twitter.com/Lewagonparis",
    next_batch: {
      slug: "1",
      starts_at: "2014-01-06",
      ends_at: "2014-03-07",
      last_seats: false,
      teachers: [
        {
          id: 1,
          github_nickname: "ssaunier",
          gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
          first_name: "Sébastien",
          last_name: "Saunier",
          bio: {
            fr: "la bio de seb",
            en: "seb's bio"
          }
        },
        {
          id: 2,
          github_nickname: "Papillard",
          gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
          first_name: "Boris",
          last_name: "Paillard",
          bio: {
            fr: "la bio de boris",
            en: "boris' bio"
          }
        }
      ],
      teacher_assistants: [
        {
          id: 3,
          github_nickname: "Tchret",
          gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
          first_name: "Thomas",
          last_name: "Chrétien",
          bio: {
            fr: "la bio de tchret",
            en: "tchret's bio"
          }
        }
      ]
    }
  }
}
```

## Alumni

`GET /api/v1/alumni`

```json
{
  alumni: [
    {
      id: 1,
      github_nickname: "spongebob",
      gravatar_url: "https://avatars.githubusercontent.com/u/50518?v=3",
      first_name: "Sponge",
      last_name: "Bob",
      city: "Paris",
      batch_slug: "15"
    },
    {
      id: 1,
      github_nickname: "unclescrooge",
      gravatar_url: "https://avatars.githubusercontent.com/u/50518?v=3",
      first_name: "Uncle",
      last_name: "Scrooge",
      city: "Brussels",
      batch_slug: "13"
    }
  ]
}
```

`GET /api/v1/alumni?city=paris`

```json
{
  alumni: [
    {
      id: 1,
      github_nickname: "spongebob",
      gravatar_url: "https://avatars.githubusercontent.com/u/50518?v=3",
      first_name: "Sponge",
      last_name: "Bob",
      city: "Paris",
      batch_slug: "15"
    }
  ]
}
```

## Staff

`GET /api/v1/staff`

```json
{
  staff: {
    teachers: [
      {
        id: 1,
        github_nickname: "ssaunier",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Sébastien",
        last_name: "Saunier",
        bio: {
          fr: "la bio de seb",
          en: "seb's bio"
        }
        batches: [
          {
            slug: "12",
            city: "Paris"
          },
          {
            slug: "13",
            city: "Los Angeles"
          }
        ]
      },
      {
        id: 4,
        github_nickname: "cveneziani",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Cecile",
        last_name: "Veneziani",
        bio: {
          fr: "la bio de cecile",
          en: "Cecile's bio"
        },
        batches: [
          {
            slug: "11",
            city: "Lille"
          }
        ]
      }
    ],
    teacher_assistants: [
      {
        id: 3,
        github_nickname: "Tchret",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Thomas",
        last_name: "Chrétien",
        bio: {
          fr: "la bio de tchret",
          en: "tchret's bio"
        },
        batches: [
          {
            slug: "12",
            city: "Paris"
          }
        ]
      }
    ]
  }
}
```

`GET /api/v1/staff?city=paris`

```json
{
  staff: {
    teachers: [
      {
        id: 1,
        github_nickname: "ssaunier",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Sébastien",
        last_name: "Saunier",
        bio: {
          fr: "la bio de seb",
          en: "seb's bio"
        }
        batches: [
          {
            slug: "12",
            city: "Paris"
          },
          {
            slug: "13",
            city: "Los Angeles"
          }
        ]
      },
    ],
    teacher_assistants: [
      {
        id: 3,
        github_nickname: "Tchret",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Thomas",
        last_name: "Chrétien",
        bio: {
          fr: "la bio de tchret",
          en: "tchret's bio"
        },
        batches: [
          {
            slug: "12",
            city: "Paris"
          }
        ]
      }
    ]
  }
}
```

## Projects

`GET /api/v1/projects`

```json
{
  projects: [
    {
      id: 1,
      url: "http://www.getkudoz.com/",
      tagline: "Tinder for job search.",
      position: 1,
      thumbnail: "http://path.jpg",
      makers: [ "..."" ],
      batch: "1",
      city: "Paris"
    },
    {
      id: 2,
      url: "http://sharkrank.co/",
      tagline: "Rate and review angel investors.",
      position: 2,
      thumbnail: "http://path.jpg",
      makers: [ "..."" ],
      batch: "2",
      city: "Brussels"
    }
  ]
}
```

`GET /api/v1/projects?city=paris`

```json
{
  projects: [
    {
      id: 1,
      url: "http://www.getkudoz.com/",
      tagline: "Tinder for job search.",
      position: 1,
      thumbnail: "http://path.jpg",
      makers: [ "..."" ],
      batch: "1",
      city: "Paris"
    }
  ]
}
```

### Featured products

`GET /api/v1/projects?featured=true`

`GET /api/v1/projects?city=paris&featured=true`

## Stories

`GET /api/v1/stories`

``json
{
  stories: [
    {
      id: 1,
      description: {
        fr: "Lancée en 2014, la startup Kudoz vient d’annoncer avoir bouclé une levée de fonds de 1,2 million d’euros auprès de Schibsted Media Group, société qui détient également Leboncoin et MonsieurDrive.",
        en: "Lunched in 2014, Kudoz has just raised 1,2 million euros with Schibsted Media Group, the investor of Leboncoin & MonsieurDrive."
      },
      picture: "http://path.jpg",
      alumni: {
        id: 15,
        github_nickname: "Olixier",
        gravatar_url: "https://avatars.githubusercontent.com/u/2471555?v=3",
        first_name: "Olivier",
        last_name: "Xu",
        slug: "15",
        city: "Paris"
      }
    }
  ]
}
