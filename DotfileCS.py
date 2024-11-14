# Python script for Git Command Reference
categories = {
    1: {
        "category_name": "Basic Setup",
        "commands": {
            1: {"name": "Initialize Repository", "command": "git init", "details": "Initializes a new Git repository in the current directory, setting up all necessary files and structures."},
            2: {"name": "Add Remote Origin", "command": "git remote add origin <repo-url>", "details": "Links the local repository to a remote repository specified by <repo-url>, enabling push/pull operations."},
            3: {"name": "Clone Repository", "command": "git clone <repo-url>", "details": "Clones a remote repository to your local machine, copying all files and commit history."}
        }
    },
    2: {
        "category_name": "Committing Changes",
        "commands": {
            1: {"name": "Initial Commit", "command": "git add . && git commit -m 'Initial commit'", "details": "Stages all files and commits them as the initial commit with a message."},
            2: {"name": "Stage Changes", "command": "git add <file> or git add .", "details": "Stages specified changes to be included in the next commit. Use 'git add .' to stage all changes in the current directory."},
            3: {"name": "Commit with Amend", "command": "git commit --amend", "details": "Edits the last commit, allowing you to change the commit message or include additional changes."}
        }
    },
    3: {
        "category_name": "Branch Management",
        "commands": {
            1: {"name": "List Branches", "command": "git branch", "details": "Lists all local branches, with the current branch marked by an asterisk (*)."},
            2: {"name": "Switch Branch", "command": "git checkout <branch-name>", "details": "Switches to the specified branch and updates the working directory."},
            3: {"name": "Rename to Main", "command": "git branch -m master main", "details": "Renames the current branch from 'master' to 'main' to align with modern naming conventions."},
            4: {"name": "Delete Local Branch", "command": "git branch -d <branch-name>", "details": "Deletes a local branch if it has been merged. Use -D to force delete unmerged branches."},
            5: {"name": "Delete Remote Branch", "command": "git push origin --delete <branch-name>", "details": "Removes a branch from the remote repository, useful for cleanup."}
        }
    },
    # Other categories...
}

# Function to display all categories
def display_categories():
    print("\n# ---------------------------------")
    print("\nAvailable Git Command Categories:\n")
    for key in categories:
        print(f"{key}: {categories[key]['category_name']}")
    print("\nEnter the number of a category to list its commands or type '0' or 'exit' to quit.")

# Function to display commands in a selected category
def display_commands(category_key):
    category = categories[category_key]
    print(f"\n# ---------------------------------")
    print(f"\nCommands in {category['category_name']}:\n")
    
    # Display each command with numbering starting from 1
    for idx, (cmd_key, cmd) in enumerate(category['commands'].items(), start=1):
        print(f"{idx}: {cmd['name']}")
    print("\nEnter the command number for details or type '0' to go back.\n")

# Main script loop
while True:
    display_categories()
    user_input = input("\nEnter the category number: ").strip()
    
    if user_input in ['0', 'exit']:
        print("\nExiting... Goodbye!")
        break
    
    try:
        category_key = int(user_input)
        
        if category_key in categories:
            while True:
                display_commands(category_key)
                command_input = input("Select a command number: ").strip()
                
                if command_input == '0':
                    break  # Go back to category selection
                
                try:
                    command_idx = int(command_input)
                    command_list = list(categories[category_key]['commands'].values())
                    
                    # Ensure selected command number is within range
                    if 1 <= command_idx <= len(command_list):
                        cmd = command_list[command_idx - 1]
                        print(f"\n# ---------------------------------")
                        print(f"\nCommand: {cmd['command']}\nDetails: {cmd['details']}\n")
                        input("\nPress Enter to go back to the commands list.")
                    else:
                        print("\nInvalid command number. Please try again.")
                
                except ValueError:
                    print("\nInvalid input. Please enter a valid command number or '0' to go back.")
        else:
            print("\nInvalid category. Please select a valid category number.")
    
    except ValueError:
        print("\nInvalid input. Please enter a valid category number or '0' to exit.")
