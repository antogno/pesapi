# PES API

<p>
	<a href="https://github.com/antogno/pesapi/blob/master/LICENSE"><img src="https://img.shields.io/github/license/antogno/pesapi" alt="License"></a>
	<a href="https://github.com/antogno/pesapi/commits"><img src="https://img.shields.io/github/last-commit/antogno/pesapi" alt="Last commit"></a>
	<a href="https://github.com/antogno/pesapi/releases/latest"><img src="https://img.shields.io/github/v/tag/antogno/pesapi?label=last%20release" alt="Last release"></a>
</p>

A GraphQL Pro Evolution Soccer 6 API.

<p align="center">
	<img alt="Screenshot" src="https://raw.githubusercontent.com/antogno/pesapi/master/public/images/screenshot.png">
</p>

---

## Table of contents

- [What is PES API?](#what-is-pes-api)
- [Usage](#usage)
- [Query examples](#query-examples)
  - [Example 1](#example-1)
  - [Example 2](#example-2)
  - [Example 3](#example-3)
- [License](#license)
- [Links](#links)

## What is PES API?

PES API is a GraphQL Pro Evolution Soccer 6 API. It has all the information regarding players, teams, formations, leagues, abilities and special abilities, stadiums and more.

PES API also exists thanks to:

- [Flagpedia][1];
- PESFan Editor.

## Usage

### Pre-requisites

- VS Code with the [Dev Containers][2] extension;
- Docker.

### Setup

Copy the `.env.example` file in the root of the project, name it `.env` and change the values accordingly.

```console
$ cp .env.example .env
```

Then, open VS Code and use the [command palette][3] shortcut (usually `Ctrl + Shift + P`) and start typing _container_. You should see a _Reopen in Container_ command: press `Enter`.

Once done, open the container terminal (usually `Ctrl + J`), and run the following commands:

```console
$ npm install
```

```console
$ npm run db:reset
```

When asked about resetting the database, answer affirmatively.

### Run

```console
$ npm run start:dev
```

The API is now accessible in [localhost:4000/graphql](http://localhost:4000/graphql) (change the port with the one you specified in the `.env` file).

## Query examples

### Example 1

Obtaining the starters of the Classic Italy team, with their names, age, stronger foot, jersey number, position and whether they are team captain or not. The list is also sorted by name.

#### Query

```graphql
query Players(
	$where: PlayersPositionsWhereInput
	$playersWhere2: PlayerWhereInput
	$playersSettingsWhere2: PlayersSettingsWhereInput
	$playersSettingsWhere3: PlayersSettingsWhereInput
	$orderBy: [PlayerOrderByWithRelationInput!]
) {
	players(where: $playersWhere2, orderBy: $orderBy) {
		id
		nationality {
			name
		}
		name
		realName
		age: playersSettings(where: $playersSettingsWhere2) {
			value
		}
		strongerFoot: playersSettings(where: $playersSettingsWhere3) {
			settingValue {
				value
			}
		}
		playersTeams {
			number
			captain
		}
		playersPositions(where: $where) {
			position {
				short
			}
		}
	}
}
```

#### Variables

```json
{
	"where": {
		"registered": {
			"equals": true
		}
	},
	"playersWhere2": {
		"playersTeams": {
			"some": {
				"team": {
					"is": {
						"name": {
							"equals": "Classic Italy"
						}
					}
				},
				"starter": {
					"equals": true
				}
			}
		}
	},
	"playersSettingsWhere2": {
		"setting": {
			"is": {
				"name": {
					"equals": "Age"
				}
			}
		}
	},
	"playersSettingsWhere3": {
		"setting": {
			"is": {
				"name": {
					"equals": "Stronger foot"
				}
			}
		}
	},
	"orderBy": [
		{
			"name": "asc"
		}
	]
}
```

#### Result

| id   | nationality.name | name       | realName  | age.0.value | strongerFoot.0.settingValue.value | playersTeams.0.number | playersTeams.0.captain | playersPositions.0.position.short |
| ---- | ---------------- | ---------- | --------- | ----------- | --------------------------------- | --------------------- | ---------------------- | --------------------------------- |
| 1383 | Italy            | Benboli    | Bergomi   | 26          | R                                 | 3                     | false                  | CB                                |
| 1388 | Italy            | Carnalli   | Cabrini   | 24          | L                                 | 4                     | false                  | WB                                |
| 1385 | Italy            | Corgacci   | Collovati | 25          | R                                 | 5                     | false                  | CB                                |
| 1389 | Italy            | Corthan    | Conti     | 27          | L                                 | 16                    | false                  | WF                                |
| 1382 | Italy            | Geancarle  | Gentile   | 28          | R                                 | 6                     | true                   | CB                                |
| 1391 | Italy            | Gregollini | Graziani  | 30          | R                                 | 19                    | false                  | CF                                |
| 1390 | Italy            | Loggu      | Rossi     | 25          | R                                 | 20                    | false                  | CF                                |
| 1386 | Italy            | Ormani     | Oriali    | 29          | R                                 | 13                    | false                  | DMF                               |
| 1384 | Italy            | Shirme     | Scirea    | 29          | R                                 | 7                     | false                  | CWP                               |
| 1387 | Italy            | Taugani    | Tardelli  | 27          | R                                 | 14                    | false                  | CMF                               |
| 1381 | Italy            | Zoru       | Zoff      | 40          | R                                 | 1                     | false                  | GK                                |

### Example 2

Obtaining the Premier League teams (with their names, formation and stadium) that have a stadium with more than 35000 seats, sorted by capacity.

#### Query

```graphql
query Teams($where: TeamWhereInput, $orderBy: [TeamOrderByWithRelationInput!]) {
	teams(where: $where, orderBy: $orderBy) {
		id
		name
		realName
		short
		formation {
			name
		}
		stadium {
			name
			capacity
		}
	}
}
```

#### Variables

```json
{
	"where": {
		"league": {
			"is": {
				"name": {
					"equals": "England League"
				}
			}
		},
		"stadium": {
			"is": {
				"capacity": {
					"gt": 35000
				}
			}
		}
	},
	"orderBy": [
		{
			"stadium": {
				"capacity": "desc"
			}
		}
	]
}
```

#### Result

| id  | name                   | realName          | short | formation.name | stadium.name       | stadium.capacity |
| --- | ---------------------- | ----------------- | ----- | -------------- | ------------------ | ---------------- |
| 16  | South Yorkshire        | Sheffield United  | SYK   | 4-4-2          | Catalonia Stadium  | 115000           |
| 8   | West London White      | Fulham            | WLW   | 4-4-2          | Hauptstadtstadion  | 74176            |
| 11  | Manchester United      |                   | MCU   | 4-4-2          | Old Trafford       | 67000            |
| 12  | Teesside               | Middlesbrough     | TSI   | 4-4-2          | Old Trafford       | 67000            |
| 14  | Pompy                  | Portsmouth        | PMP   | 4-4-2          | Estadio Gran Chaco | 58000            |
| 19  | East London            | West Ham United   | ELD   | 4-4-2          | Estadio Gran Chaco | 58000            |
| 13  | Tyneside               | Newcastle United  | TYS   | 4-5-1          | Magpie Park        | 52193            |
| 5   | South East London Reds | Charlton Athletic | SLR   | 4-4-2          | Diamond Stadium    | 50900            |
| 6   | London FC              | Chelsea           | LDN   | 4-3-3          | Diamond Stadium    | 50900            |
| 10  | Man Blue               | Manchester City   | MAB   | 4-4-2          | Nakhon Ratchasima  | 49350            |
| 18  | Hertfordshire          | Watford           | HFS   | 4-4-2          | Nakhon Ratchasima  | 49350            |
| 20  | Lancashire Athletic    | Wigan Athletic    | LAT   | 4-4-2          | Nakhon Ratchasima  | 49350            |
| 15  | Berkshire Blues        | Reading           | BSB   | 4-4-2          | Lutecia Park       | 48527            |
| 9   | Merseyside Red         | Liverpool         | MSR   | 4-4-2          | Red Cauldron       | 45000            |
| 1   | Arsenal                |                   | ASN   | 4-4-2          | Highbury           | 38500            |
| 2   | West Midlands Village  | Aston Villa       | WMV   | 4-5-1          | Highbury           | 38500            |

### Example 3

Obtaining forwards who have the "Shot power" ability value greater than or equal to 90 and who have the "Middle shooting" special ability (which could be defined as a _long-range shooting_ special ability).

#### Query

```graphql
query Players(
	$where: PlayersPositionsWhereInput
	$playersTeamsWhere2: PlayersTeamsWhereInput
	$playersWhere2: PlayerWhereInput
	$playersAbilitiesWhere2: PlayersAbilitiesWhereInput
) {
	players(where: $playersWhere2) {
		id
		name
		playersPositions(where: $where) {
			position {
				short
			}
		}
		clubTeam: playersTeams(where: $playersTeamsWhere2) {
			team {
				name
			}
		}
		playersAbilities(where: $playersAbilitiesWhere2) {
			value
		}
	}
}
```

#### Variables

```json
{
	"where": {
		"registered": {
			"equals": true
		}
	},
	"playersTeamsWhere2": {
		"team": {
			"is": {
				"league": {
					"is": {
						"leagueCategory": {
							"is": {
								"name": {
									"equals": "Club"
								}
							}
						}
					}
				}
			}
		}
	},
	"playersWhere2": {
		"playersAbilities": {
			"some": {
				"value": {
					"gte": 90
				},
				"ability": {
					"is": {
						"name": {
							"equals": "Shot power"
						}
					}
				}
			}
		},
		"playersSpecialAbilities": {
			"some": {
				"active": {
					"equals": true
				},
				"specialAbility": {
					"is": {
						"name": {
							"equals": "Middle shooting"
						}
					}
				}
			}
		},
		"playersPositions": {
			"some": {
				"registered": {
					"equals": true
				},
				"position": {
					"is": {
						"positionCategory": {
							"is": {
								"name": {
									"equals": "Forward"
								}
							}
						}
					}
				}
			}
		},
		"playersTeams": {
			"some": {
				"team": {
					"is": {
						"league": {
							"is": {
								"leagueCategory": {
									"is": {
										"name": {
											"equals": "Club"
										}
									}
								}
							}
						}
					}
				}
			}
		}
	},
	"playersAbilitiesWhere2": {
		"ability": {
			"is": {
				"name": {
					"equals": "Shot power"
				}
			}
		}
	}
}
```

#### Result

| id   | name        | playersPositions.0.position.short | clubTeam.0.team.name   | playersAbilities.0.value |
| ---- | ----------- | --------------------------------- | ---------------------- | ------------------------ |
| 2034 | Niang       | CF                                | Olympique de Marseille | 91                       |
| 1715 | Luque       | CF                                | Tyneside               | 93                       |
| 1552 | Hasselbaink | CF                                | South East London Reds | 91                       |
| 1045 | Adriano     | CF                                | Inter                  | 99                       |
| 769  | Eto'o       | CF                                | F.C. Barcelona         | 90                       |
| 3610 | Rivaldo     | SS                                | Olympiacos Piraeus     | 91                       |
| 1193 | Recoba      | SS                                | Inter                  | 93                       |
| 700  | Shevchenko  | SS                                | London FC              | 90                       |
| 308  | Totti       | SS                                | A.S. Roma              | 91                       |
| 160  | Rooney      | SS                                | Manchester United      | 90                       |
| 446  | C. Ronaldo  | WF                                | Manchester United      | 90                       |

## License

PES API is licensed under the terms of the [GNU General Public License v3.0][4].

For more information, see the [GNU website][5].

## Links

- [GitHub][6]
- [LinkedIn][7]
- [X][8]

[1]: https://flagpedia.net
[2]: https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers
[3]: https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette
[4]: https://github.com/antogno/pesapi/blob/master/LICENSE
[5]: https://www.gnu.org/licenses/gpl-3.0.html
[6]: https://github.com/antogno/pesapi
[7]: https://www.linkedin.com/in/antonio-granaldi/
[8]: https://twitter.com/agranaldi
