extends EditorScript
## Tileset Processor - Helper script for processing sprite sheets into TileSets
## This script helps extract and organize tileset elements

## Usage:
## 1. Place your tileset image in: assets/sprites/environment/dungeons/tilesets/
## 2. Run this script from Godot's Script menu
## 3. Follow the prompts to extract tiles

var tileset_path: String = "res://assets/sprites/environment/dungeons/tilesets/"
var props_path: String = "res://assets/sprites/environment/dungeons/props/"

func _run():
	print("Tileset Processor - Ready to process tilesets")
	print("Place your tileset images in: ", tileset_path)
	print("\nThis script will help you:")
	print("1. Extract individual tiles from sprite sheets")
	print("2. Create TileSet resources")
	print("3. Organize props and animated elements")
	print("\nFor now, use Godot's built-in TileSet editor:")
	print("1. Open your tileset image in Godot")
	print("2. Create a new TileSet resource")
	print("3. Use 'New Atlas' to define tile regions")
	print("4. Set tile size (e.g., 32x32 or 16x16)")
	print("5. Paint your levels with TileMap nodes")
