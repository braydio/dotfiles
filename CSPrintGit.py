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
            4: {"name": "Initial Commit", "command": "git add . && git commit -m 'Initial commit'", "details": "Stages all files and commits them as the initial commit with a message."},
            5: {"name": "Stage Changes", "command": "git add <file> or git add .", "details": "Stages specified changes to be included in the next commit. Use 'git add .' to stage all changes in the current directory."},
            6: {"name": "Commit with Amend", "command": "git commit --amend", "details": "Edits the last commit, allowing you to change the commit message or include additional changes."}
        }
    },
    3: {
        "category_name": "Branch Management",
        "commands": {
            7: {"name": "List Branches", "command": "git branch", "details": "Lists all local branches, with the current branch marked by an asterisk (*)."},
            8: {"name": "Switch Branch", "command": "git checkout <branch-name>", "details": "Switches to the specified branch and updates the working directory."},
            9: {"name": "Rename to Main", "command": "git branch -m master main", "details": "Renames the current branch from 'master' to 'main' to align with modern naming conventions."},
            10: {"name": "Delete Local Branch", "command": "git branch -d <branch-name>", "details": "Deletes a local branch if it has been merged. Use -D to force delete unmerged branches."},
            11: {"name": "Delete Remote Branch", "command": "git push origin --delete <branch-name>", "details": "Removes a branch from the remote repository, useful for cleanup."}
        }
    },
    4: {
        "category_name": "Merging and Rebase",
        "commands": {
            12: {"name": "Rebase Branch", "command": "git rebase <branch>", "details": "Integrates changes from one branch into another by rewriting commit history. Useful for maintaining a clean project history."},
            13: {"name": "Merge Branches", "command": "git merge <branch>", "details": "Merges another branch into the current branch."}
        }
    },
    5: {
        "category_name": "Stashing and Logs",
        "commands": {
            14: {"name": "Stash Changes", "command": "git stash and git stash pop", "details": "Temporarily saves changes not ready for commit, allowing you to work on another branch or task. Use 'git stash pop' to apply stashed changes back to the working directory."},
            15: {"name": "View Commit Log", "command": "git log", "details": "Displays a log of commits in the repository. Use 'git log --oneline' for a simplified view."}
        }
    },
    6: {
        "category_name": "Fetching and Pulling",
        "commands": {
            16: {"name": "Pull Changes", "command": "git pull", "details": "Fetches and merges changes from the remote repository into the current branch."},
            17: {"name": "Fetch Updates", "command": "git fetch", "details": "Retrieves updates from the remote repository but doesn’t merge them into your current branch."},
            18: {"name": "Fetch All PRs", "command": "git fetch origin 'refs/pull/*/head:refs/remotes/origin/pr/*'", "details": "Fetches all pull request references from the remote repository and sets them as remote branches."}
        }
    },
    7: {
        "category_name": "Pull Requests and Miscellaneous",
        "commands": {
            19: {"name": "Checkout PR", "command": "git fetch origin pull/<PR-number>/head:<branch-name> && git checkout <branch-name>", "details": "Fetches and checks out a pull request as a local branch for review or changes."},
            20: {"name": "List PRs (CLI)", "command": "gh pr list", "details": "Lists all open pull requests in the repository using GitHub CLI, including titles and statuses."},
            21: {"name": "Ensure HEAD to Main", "command": "Edit .git/HEAD", "details": "Ensures the HEAD points to the main branch, typically managed automatically."}
        }
    }
}

# Print all categories
while True:
    print("# ---------------------------------")
    print("")
    print("\nAvailable Git Command Categories:")
    for key in categories:
        print(f"{key}: {categories[key]['category_name']}")

    print("\nEnter the number of a category to list its commands or type '0' or 'exit' to quit.")

    # Get category selection
    user_input = input("\nEnter the category number: ").strip()
    if user_input in ['0', 'exit']:
        print("Exiting... Goodbye!")
        break

    try:
        category_key = int(user_input)
        if category_key in categories:
            print(f"\nCommands in {categories[category_key]['category_name']}:")
            for cmd_key, cmd in categories[category_key]['commands'].items():
                print(f"{cmd_key}: {cmd['name']}")
            
            command_input = input("\nEnter the command number for details or type 'back' to choose another category: ").strip()
            if command_input.lower() == 'back':
                continue

            try:
                command_key = int(command_input)
                if command_key in categories[category_key]['commands']:
                    cmd = categories[category_key]['commands'][command_key]
                    print(f"\nCommand: {cmd['command']}")
                    print(f"Details: {cmd['details']}")
                else:
                    print("\nCommand not found.")
            except ValueError:
                print("\nInvalid input. Please enter a number.")
        else:
            print("\nCategory not found.")
    except ValueError:
        print("\nInvalid input. Please enter a number.")


