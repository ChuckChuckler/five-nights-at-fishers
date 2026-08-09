Do you like Five Nights at Freddy's? 

Now imagine FNaF, but instead of playing as a security guard trying to survive hostile animatronics, you're a compsci teacher guarding your office from your annoying students, making sure they can't come inside so they don't annoy you and distract you from your work!

# One Night at Fisher's
This is a full-fledged FNaF fan game inspired by my own AP CompSci class. 35 hours of work and my biggest Godot project so far. Result:

- Working FNaF-esque office with working camera pan animation, doors, and door lights
- Students (the "animatronics" of this game) that actually move towards the player, with unique functionality
- Working code for all scenarios-- getting annoyed by a student (jumps care oh no), running out of power, or winning the game
- Cool SFX, atmosphere, and jumpscares!!!

![The office of the game, where you play.](https://img.itch.zone/aW1hZ2UvNDY4NjkwMi8yNzkzMTg3OC5wbmc=/original/hHM6Qm.png)
![Fang in Classroom E.](https://img.itch.zone/aW1hZ2UvNDY4NjkwMi8yNzkzMTg3OS5wbmc=/original/7Wdfz8.png)
![Mims jumspcaring you!](https://img.itch.zone/aW1hZ2UvNDY4NjkwMi8yNzkzMTg4Mi5wbmc=/original/WowdrP.png)

## How to play:
Check your cameras regularly. Make sure you know where the students are. There are blind spots right outside your doors-- use the lights to check them. Close your doors to block students from entering your office!

How to deal with each student:
- Fang: Fang will always spawn in Classroom E, his favorite room. Check back regularly to make sure he doesn't move. If you haven't looked at his camera in a while, and you hear a chuckle, he has moved! Once Fang gets to your office, the doors won't stop him-- instant game over.
- Mims and Deffery: Mims and Deffery can spawn in any camera, but won't spawn beyond the first hallways on the upper floors. From there, they'll make a random path towards your office. When you see them outside your office, close the corresponding door, and check your lights (or listen for footsteps) to see when they've left.
- Banajit: Check the tardy office regularly. There is a chance Banajit may appear in there, waiting for a tardy pass. If you hear a ding and a flurry of footsteps, he's got his tardy pass-- close the right door as quickly as you can! Once you hear a thud, it's safe to reopen the door.

You can customize difficulty through the "Customize" button on the opening screen. Make sure to change difficulties again every time you replay the game!

## Controls
- Cursor to right of screen --> turn towards right door
- Cursor to left of screen --> turn towards left door
- Green button --> turn on light
- Red button --> close door
- Cursor on brownish rectangle at bottom of screen --> open camera

# Can *you* make it to 6AM without getting annoyed...or running out of power...?

## Technical information...
To open the project in your Godot, follow these steps (Windows only):
1. Open Powershell or other terminal
2. Cd to a location you'll remember
3. Clone this repo with `git clone https://github.com/ChuckChuckler/five-nights-at-fishers`
4. Open Godot and click "Import" at the top of the screen
5. Find the repo and import the "five-nights-at-ms-fishers" folder as a project

This game is not playable on web! This is because the game uses Forward+ as its rendering engine, which is not compatible with web players. Switching to a web-compatible render engine (e.g. mobile) simply makes the game both visually bad and borderline unplayable. Please download the game, or feel free to request a demo video.
