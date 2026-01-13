#!/usr/bin/env python3
"""
AI Content Generator for Wizard Diver Game
Generates NPCs, quests, and dialogue using AI (placeholder for actual AI integration)
"""

import json
import random
from typing import Dict, List

class ContentGenerator:
    """Generates game content using AI"""
    
    def __init__(self):
        self.npc_templates = [
            "wise wizard", "mysterious merchant", "ancient spirit",
            "young apprentice", "guild master", "scholar"
        ]
        
        self.quest_types = ["collection", "exploration", "combat", "puzzle"]
        self.spell_names = [
            "Fireball", "Ice Shard", "Lightning Bolt", "Heal",
            "Shield", "Teleport", "Reveal", "Unlock"
        ]
    
    def generate_npc(self, npc_id: str = None) -> Dict:
        """Generate an NPC with personality and dialogue"""
        if not npc_id:
            npc_id = f"npc_{random.randint(1000, 9999)}"
        
        npc_type = random.choice(self.npc_templates)
        
        npc = {
            "id": npc_id,
            "name": self._generate_name(),
            "type": npc_type,
            "personality": self._generate_personality(),
            "dialogue": self._generate_dialogue(npc_type),
            "quests": []
        }
        
        return npc
    
    def generate_quest(self, quest_type: str = None) -> Dict:
        """Generate a quest"""
        if not quest_type:
            quest_type = random.choice(self.quest_types)
        
        quest = {
            "id": f"quest_{random.randint(10000, 99999)}",
            "name": self._generate_quest_name(),
            "description": self._generate_quest_description(quest_type),
            "type": quest_type,
            "objectives": self._generate_objectives(quest_type),
            "rewards": self._generate_rewards()
        }
        
        return quest
    
    def generate_dialogue(self, npc_type: str, context: str = "greeting") -> str:
        """Generate dialogue for an NPC"""
        dialogues = {
            "wise wizard": {
                "greeting": [
                    "Welcome, young mage. The path ahead is full of mysteries.",
                    "Magic flows through all things. You must learn to see it.",
                    "Many have sought power, but few understand its true nature."
                ],
                "quest": [
                    "I have a task that requires your skills.",
                    "There is something I need you to retrieve.",
                    "A dangerous quest awaits, if you're brave enough."
                ]
            },
            "mysterious merchant": {
                "greeting": [
                    "Interested in rare spells? I have what you need.",
                    "My wares are... unique. Care to browse?",
                    "I deal in things most wizards wouldn't touch."
                ],
                "quest": [
                    "I'll pay well if you can find what I'm looking for.",
                    "There's profit to be made, if you're interested.",
                    "I need someone to retrieve something for me."
                ]
            }
        }
        
        if npc_type in dialogues and context in dialogues[npc_type]:
            return random.choice(dialogues[npc_type][context])
        
        return "Hello, traveler."
    
    def _generate_name(self) -> str:
        """Generate a random name"""
        first_names = ["Aria", "Thorin", "Luna", "Zephyr", "Sage", "Orion", "Nova", "Kai"]
        last_names = ["Starweaver", "Moonwhisper", "Stormcaller", "Shadowbane", "Lightbringer"]
        return f"{random.choice(first_names)} {random.choice(last_names)}"
    
    def _generate_personality(self) -> str:
        """Generate personality traits"""
        traits = ["friendly", "mysterious", "wise", "eccentric", "serious", "cheerful"]
        return random.choice(traits)
    
    def _generate_dialogue(self, npc_type: str) -> Dict:
        """Generate dialogue options"""
        return {
            "greeting": self.generate_dialogue(npc_type, "greeting"),
            "quest": self.generate_dialogue(npc_type, "quest"),
            "farewell": "May magic guide your path."
        }
    
    def _generate_quest_name(self) -> str:
        """Generate quest name"""
        prefixes = ["The", "Seeking", "Finding", "The Lost", "The Ancient"]
        nouns = ["Spell", "Artifact", "Crystal", "Tome", "Secret"]
        return f"{random.choice(prefixes)} {random.choice(nouns)}"
    
    def _generate_quest_description(self, quest_type: str) -> str:
        """Generate quest description"""
        descriptions = {
            "collection": "Collect {count} {item} scattered throughout the realm.",
            "exploration": "Explore the {location} and discover its secrets.",
            "combat": "Defeat {count} {enemy} that threaten the area.",
            "puzzle": "Solve the ancient puzzle in the {location}."
        }
        
        template = descriptions.get(quest_type, "Complete this quest.")
        return template.format(
            count=random.randint(3, 10),
            item=random.choice(["spells", "crystals", "artifacts"]),
            location=random.choice(["castle", "dungeon", "forest"]),
            enemy=random.choice(["goblins", "skeletons", "spirits"])
        )
    
    def _generate_objectives(self, quest_type: str) -> List[Dict]:
        """Generate quest objectives"""
        objectives = []
        
        if quest_type == "collection":
            objectives.append({
                "type": "collect",
                "target": random.choice(self.spell_names),
                "count": random.randint(3, 5),
                "completed": 0
            })
        elif quest_type == "combat":
            objectives.append({
                "type": "defeat",
                "enemy": "goblin",
                "count": random.randint(5, 10),
                "completed": 0
            })
        elif quest_type == "exploration":
            objectives.append({
                "type": "explore",
                "location": random.choice(["castle", "dungeon"]),
                "completed": False
            })
        
        return objectives
    
    def _generate_rewards(self) -> Dict:
        """Generate quest rewards"""
        return {
            "mana_crystals": random.randint(50, 200),
            "experience": random.randint(100, 500),
            "spell": random.choice(self.spell_names) if random.random() > 0.7 else None
        }

def main():
    """Example usage"""
    generator = ContentGenerator()
    
    # Generate some content
    print("Generating game content...\n")
    
    # Generate NPCs
    print("NPCs:")
    for i in range(3):
        npc = generator.generate_npc()
        print(f"  - {npc['name']} ({npc['type']}): {npc['dialogue']['greeting']}")
    
    print("\nQuests:")
    for i in range(3):
        quest = generator.generate_quest()
        print(f"  - {quest['name']}: {quest['description']}")
        print(f"    Rewards: {quest['rewards']}")
    
    # Save to JSON
    content = {
        "npcs": [generator.generate_npc() for _ in range(5)],
        "quests": [generator.generate_quest() for _ in range(10)]
    }
    
    with open("generated_content.json", "w") as f:
        json.dump(content, f, indent=2)
    
    print("\nContent saved to generated_content.json")

if __name__ == "__main__":
    main()
