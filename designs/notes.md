# Design Notes

General design notes for radius-game.


## Overview

Pitch: Gradius x noita wands (other games have similar mechanics but thats the only one I know by name).


## Weapons
- base weapon is simple
- can add effects to the weapon to modify its behavior
    - set number of slots i.e. 10? 20?
    - effects inlcude:
        - multiplier: increases number of firing nodes
        - speed: increases speed of projectile
        - rate: increases rate of fire
        - size: makes projectile larger
        - explosive?: projectile explodes after a certain time
        - sequential?: projectile spawns more projectiles after a certain time
        - status effects?: projectiles apply different damage types


## Spawners

- set spawner node locations
- each node can be used as a target for instancing an enemy spawner that spawns a particular enemy
    - for a configured amount of time / configured rate
- define in a cfg file for easier customising of enemies


## Levels

- levels are just a sequence of enemies spawned at given nodes after certain delays
- each level ends with a big boss
- define in a cfg file to allow easier writing / tweaking of levels
