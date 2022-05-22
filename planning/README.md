[Back to the main page.](../README.md)

# Plans for **flutter_online_turn_based_game**

## Functions

User identification - Using Firebase:
- Registration
- Login
- Logout

Matchmaking:
- Find friends
- Game with friends
- Invite players to a game
- Set up the player count and game mode

Game:
- Generate world
    - Random generated world (maybe use wave function collapse).
    - Place collectibles, enemies and players, depending on game mode.
        - Place smaller room with strong enemies and good loot.
        - PvE
            - Spawn players together in a starting room.
            - End room with lot of enemies.
            - Longer map.
        - PvP
            - Spawn players in the maps separate parts.
            - Square map.
- Player
    - Stats
        - Health
        - Strength
        - Level - multiplier for strength and health
        - Moves in turn
    - Inventory
        - Contains items for stat boost.
    - Use items from the inventory
        - Boost health and strength.
    - Move
    - Pick up collectibles
        - Item collection is automatic.
    - Fight enemies
        - If the attacker's strength is greater than the victim's health, the attacker wins. 
        - If the victim survives, he attacks back.
        - The winner's level is upgraded by the looser's level.
            - On level up update status.
        - The winner takes the looser's inventory.
            - Item collection is automatic.
    - Leave game.
- Enemy
    - Stats
        - Health
        - Strength
        - Level - multiplier for strength and health
        - Moves in turn
    - Inventory
        - Contains items for stat boost.
    - Fight with players
- Turns
    - Every player gets N actions in a turn.
    - Actions:
        - Move
        - Attack
        - Use item
    - Notify changes
        - Who attacked the current player.
        - Who leaved the game.
        - Who won the game.
- Win
    - Win depends on game mode
    - PvP
        - Last alive player wins
    - PvE
        - Players win when all enemies are beaten.

## Screens
- [Authentication](./Auth.pdf)
- [Main page](./Home.pdf)
- [New game](./Home%20-%20New%20Game.pdf)
- [Join game](./Home%20-%20Join%20Game.pdf)
- [Game page](./Game.pdf)
- [Notifications](./Game%20-%20Notification.pdf)
- [Item info](./Game%20-%20Item.pdf)

## Database

Firestore NOSQL

Game:
- id: string // hash for identification
- mode: enum // PvP or PvE
- max_players: number // maximum player count
- players: array // list of users in the game
    - name: string // name of user
    - location: (number, number) // coordinate of the player
    - stats: object // player statistics
        - base_health: number // what to multiply with the level
        - heath: number // player current health
        - strength: number // strength of the user
        - level: number // level of the user
    - inventory: array // array of item
        - name: string
        - health_bonus: number
        - strength_bonus: number
        - level_bonus: number
    - actions: number // actions left for the player
    - notifications: array // notifications from the last turn
        - type: enum // notification type
        - from: string // id of user who triggered the notification
- enemies: array // list of enemies in the game
    - location: (number, number) // coordinate of the enemy
    - stats: object // enemy statistics
        - heath: number
        - strength: number
        - level: number
    - inventory: array // array of item
        - name: string
        - health_bonus: number
        - strength_bonus: number
        - level_bonus: number
- items: array // list of items in the game
    - name: string
    - location: (number, number) // coordinate of the item
    - health_bonus: number
    - strength_bonus: number
    - level_bonus: number
    - action_bonus: number
- map: array // tiles of the map
    - tile_id: number // id of the tile
    - is_wall: bool // can player move on this tile or this is a barrier
    - rotation: enum // orientation of the tile / graphic
- turn: object
    - turn_limit: number
    - number: number // number of turns
    - current_player: string // user id

## App structure

- Main
    - Firebase auth
- Authentication
    - Firebase auth
- Home
    - Firebase Firestore
- Game
    - Firebase Firestore