# 
# amireux-client

## Components:

- Online Chatbot

  - We call GPT3.5 API and used prompt engineering to make it generate featured responses. In prompt engineering, we apply the technique of “Chain of Thoughts” and “Few Shots” and help the AI handle complex problems, like personality analysis and featured response.
  - The GPT model is integrated in Flowise and we call the Flowise API in our server to realize communication

- Databases

  - We use an SQLite3 database to store all the chat history of user and AI agent for personality analysis.

- Frontend

  - We use Flutter to make our frontend and insert animation as well 

## How to Run
- Make sure to install Flutter SDK, then execute `flutter run` at the source directory.
