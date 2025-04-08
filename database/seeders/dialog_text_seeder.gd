class_name DialogTextSeeder
extends DatabaseSeeder


const _NO_ROUTE_ID: int = 1
const _GOOD_ENDING_ID: int = 2
const _BAD_ENDING_ID: int = 3
const _PERFECT_ENDING_ID: int = 4


func _seed() -> void:
    var row: DialogText
    var rel: NpcStoryDialog
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Man:\nI wish I could leave the depths..."
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 1
    rel.story_flag_id = 1
    rel.route_flag_id = _NO_ROUTE_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Sigh..."
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Woman:\nI wonder how it's like on the surface..."
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 2
    rel.story_flag_id = 1
    rel.route_flag_id = _NO_ROUTE_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Surely it's not as miserable as here..."
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "???:\nListen you people of the depths."
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 3
    rel.story_flag_id = 1
    rel.route_flag_id = _GOOD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "I came below to my own, on the surface, but my own did not receive me."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Therefore I now come below to you people of the depths. To see if any will listen to my words."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Believe me when I tell you that I come from above, and not just from above the depths, but also from beyond the surface."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "You people of the depths will say: \"But no one among us has ever seen the surface...\", so did the people of the surface not believe that I come from above."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "You believe that the eternal kingdom lies above. Truly I tell you, that the Kingdom of Heaven is within, do not miss it."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "If you believe my words, you must testify and proclaim the good news to all who would listen."
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Guard:\nWhy does the king push his subjects so hard to climb out of the depths?"
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 7
    rel.story_flag_id = 1
    rel.route_flag_id = _BAD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Has anyone even ever reached above? Is it really worth the toll?"
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "General:\nWe must work harder so that our kingdom can climb out of the depths."
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 6
    rel.story_flag_id = 1
    rel.route_flag_id = _BAD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Publish this everywhere: whoever offers a great service to the kingdom will be greatly rewarded!"
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Man:\nWe don't need to leave the depths?"
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 1
    rel.story_flag_id = 1
    rel.route_flag_id = _GOOD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "What's above the depths is within?"
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Hmm..."
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Somehow, your words make me feel at peace. I believe you."
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Woman:\nIt's not better on the surface than it is in the depths?"
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 2
    rel.story_flag_id = 1
    rel.route_flag_id = _GOOD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "How do you know that?"
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "The Kingdom of Heaven? Where is that?"
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Within...?"
    row.next_dialog_text_id = row.id + 1
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "This makes me look at it in another light. Thank you."
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Guard:\nA peace that the king can't offer?"
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 7
    rel.story_flag_id = 1
    rel.route_flag_id = _GOOD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "How can I serve this Kingdom of Heaven?"
    row.next_dialog_text_id = 0
    
    # ---
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "General:\nSo you are the one sowing the seeds of rebellion in our kingdom."
    row.next_dialog_text_id = row.id + 1
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 6
    rel.story_flag_id = 1
    rel.route_flag_id = _GOOD_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
    
    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "Guards! Seize him!"
    row.next_dialog_text_id = 0
    
    # ---

    row = DialogText.new()
    DB.table("dialog_text").insert(row)
    row.text = "???:\nBlessed are you, who has not seen, and yet, has believed. Let us go now."
    row.next_dialog_text_id = 0
    
    rel = NpcStoryDialog.new()
    rel.npc_id = 3
    rel.story_flag_id = 1
    rel.route_flag_id = _PERFECT_ENDING_ID
    rel.dialog_text_id = row.id
    DB.table("npc_story_dialog").insert(rel)
