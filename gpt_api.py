import openai
import os

# Load the API key from environment variables
openai.api_key = os.getenv("OPENAI_API_KEY")

def chat_with_gpt():
    print("Start chatting with ChatGPT! Type 'exit' to end the chat.\n")
    
    # Contextual history to maintain conversation
    messages = [{"role": "system", "content": "You are a helpful assistant."}]
    
    while True:
        user_input = input("You: ")
        
        if user_input.lower() in ["exit", "quit"]:
            print("Chat ended.")
            break
        
        # Add the user message to the history
        messages.append({"role": "user", "content": user_input})
        
        try:
            # Send request to OpenAI API
            response = openai.ChatCompletion.create(
                model="gpt-3.5-turbo",  # Use "gpt-4" if you have access to GPT-4 and want it.
                messages=messages
            )
            
            # Extract assistant's reply
            assistant_reply = response['choices'][0]['message']['content']
            print(f"ChatGPT: {assistant_reply}\n")
            
            # Add the assistant's reply to the history
            messages.append({"role": "assistant", "content": assistant_reply})
        
        except Exception as e:
            print(f"An error occurred: {e}")

if __name__ == "__main__":
    chat_with_gpt()
